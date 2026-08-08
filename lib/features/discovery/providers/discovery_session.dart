import 'dart:async';
import 'dart:io';
import 'package:flanexec/core/networking/host_resolver.dart';
import 'package:flanexec/core/networking/ip_utils.dart';
import 'package:flanexec/core/networking/nbns_resolver.dart';
import 'package:flanexec/core/networking/os_fingerprinter.dart';
import 'package:flanexec/core/networking/pinger.dart';
import 'package:flanexec/core/networking/port_scanner.dart';
import 'package:flanexec/core/protocols/ldap/domain_probe.dart';
import 'package:flanexec/core/protocols/smb/smb_hostname_probe.dart';
import 'package:flanexec/core/utils/logger.dart';
import 'package:flanexec/features/discovery/providers/scan_config.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flanexec/features/settings/providers/settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pool/pool.dart';

enum DiscoveryStatus { idle, scanning, done, error }

class DiscoveryState {
  final DiscoveryStatus status;
  final List<Host> hosts;
  final double progress;
  final String? currentIp;
  final String? error;

  DiscoveryState({
    this.status = DiscoveryStatus.idle,
    this.hosts = const [],
    this.progress = 0,
    this.currentIp,
    this.error,
  });

  DiscoveryState copyWith({
    DiscoveryStatus? status,
    List<Host>? hosts,
    double? progress,
    String? currentIp,
    String? error,
  }) {
    return DiscoveryState(
      status: status ?? this.status,
      hosts: hosts ?? this.hosts,
      progress: progress ?? this.progress,
      currentIp: currentIp ?? this.currentIp,
      error: error ?? this.error,
    );
  }
}

class DiscoverySessionNotifier extends StateNotifier<DiscoveryState> {
  DiscoverySessionNotifier(this.ref) : super(DiscoveryState());

  final Ref ref;
  bool _isCanceled = false;

  Future<void> startScan() async {
    runZonedGuarded(() async {
      final config = ref.read(scanConfigProvider);
      final settings = ref.read(settingsProvider);
      
      ref.read(loggerProvider.notifier).log('engine', 'Scan initialization started...');
      
      if (!IpUtils.isValidCidr(config.cidr)) {
        ref.read(loggerProvider.notifier).log('engine', 'Invalid CIDR: ${config.cidr}', level: LogLevel.error);
        state = state.copyWith(status: DiscoveryStatus.error, error: 'Invalid CIDR');
        return;
      }

      _isCanceled = false;
      state = DiscoveryState(status: DiscoveryStatus.scanning);
      
      final localIp = await IpUtils.getLocalIpAddress();
      if (localIp == null || localIp == '127.0.0.1') {
        ref.read(loggerProvider.notifier).log(
          'engine', 
          'CRITICAL: No local network interface found. स्टैंडअलोन (Standalone) mode: Please ensure the app has "Local Network" permission in System Settings > Privacy & Security.',
          level: LogLevel.error,
        );
      }

      ref.read(loggerProvider.notifier).log(
        localIp ?? '0.0.0.0', 
        'Starting scan from local interface. Target: ${config.cidr}',
        level: LogLevel.info,
      );

      final ips = IpUtils.expandCidr(config.cidr);
      ref.read(loggerProvider.notifier).log('engine', 'Expanded CIDR to ${ips.length} IPs');
      
      if (ips.isEmpty) {
        state = state.copyWith(status: DiscoveryStatus.done);
        return;
      }

      final total = ips.length;
      int processed = 0;
      
      final pool = Pool(settings.defaultConcurrency);
      final List<Future> tasks = [];
      
      for (final ip in ips) {
        if (_isCanceled) break;

        tasks.add(pool.withResource(() async {
          if (_isCanceled) return;

          final targetIp = ip;
          try {
            state = state.copyWith(currentIp: targetIp);

            // 1. Ping Check
            final pingResult = await Pinger.ping(targetIp, timeout: Duration(seconds: settings.defaultTimeout));

            if (pingResult.status == PingStatus.alive) {
              ref.read(loggerProvider.notifier).log(targetIp, 'Host is alive', level: LogLevel.info);
              // 2. Add host immediately with minimal info
              final initialHost = Host(
                ip: targetIp,
                status: 'alive',
                rttMs: pingResult.rttMs,
                ttl: pingResult.ttl,
                lastSeen: DateTime.now(),
                ports: pingResult.respondedPort != null 
                  ? [Port(port: pingResult.respondedPort!, protocol: 'tcp', state: 'open')] 
                  : [],
              );
              _addHost(initialHost);

              // 3. Resolve Identity (Parallel NBNS, SMB, LDAP, DNS)
              _resolveHostIdentity(targetIp);

              // 4. Port Scan
              final scanStream = PortScanner.scanPorts(
                targetIp,
                config.ports,
                concurrency: 5,
                timeout: Duration(seconds: settings.defaultTimeout),
              );

              await for (final result in scanStream) {
                if (_isCanceled) break;
                _updateHostPorts(targetIp, result);
              }
              
              // 5. Final Fingerprint for this host
              _fingerprintHost(targetIp);
            }
          } catch (e) {
            // Silently ignore expected network errors during scan
          } finally {
            processed++;
            // Ensure we don't exceed 1.0 until the very end
            final newProgress = (processed / total).clamp(0.0, 0.999);
            state = state.copyWith(progress: newProgress);
          }
        }));
      }

      // Wait for all tasks to actually complete
      await Future.wait(tasks);
      await pool.close();

      if (!_isCanceled) {
        state = state.copyWith(status: DiscoveryStatus.done, progress: 1.0);
      }
    }, (error, stack) {
      // Catch rogue socket exceptions that happen after cleanup
    });
  }

  void _addHost(Host host) {
    if (state.hosts.any((h) => h.ip == host.ip)) return;
    state = state.copyWith(hosts: [...state.hosts, host]);
    _fingerprintHost(host.ip);
  }

  void _updateHostName(String ip, String hostname) {
    final updatedHosts = state.hosts.map((h) {
      if (h.ip == ip) {
        return h.copyWith(hostname: hostname);
      }
      return h;
    }).toList();
    state = state.copyWith(hosts: updatedHosts);
    _fingerprintHost(ip);
  }

  Future<void> _resolveHostIdentity(String ip) async {
    NbnsResolver.query(ip).then((res) => _updateFromNbns(ip, res));
    SmbHostnameProbe.probe(ip).then((res) => _updateFromSmb(ip, res));
    HostResolver.resolveHostname(ip).then((res) => _updateHostName(ip, res!)).catchError((_) {});
    
    // Explicit Apple Probe if we suspect it might be Apple or if it's currently Linux/Unknown
    _probeApplePorts(ip);
  }

  Future<void> _probeApplePorts(String ip) async {
    final applePorts = [62078, 5353, 5000];
    for (var port in applePorts) {
      try {
        final socket = await Socket.connect(ip, port, timeout: const Duration(milliseconds: 400));
        socket.destroy();
        _updateHostPorts(ip, PortScanResult(host: ip, port: port, state: PortState.open));
        break; // One hit is enough to confirm Apple presence
      } catch (_) {}
    }
  }

  void _updateFromNbns(String ip, NbnsResult? res) {
    if (res == null || _isCanceled) return;
    final updatedHosts = state.hosts.map((h) {
      if (h.ip == ip) {
        return h.copyWith(
          macAddress: res.macAddress ?? h.macAddress,
          netbiosName: res.netbiosName ?? h.netbiosName,
          domain: res.domain ?? h.domain,
          isDomainController: res.isDomainController || h.isDomainController,
        );
      }
      return h;
    }).toList();
    state = state.copyWith(hosts: updatedHosts);
    _fingerprintHost(ip);
  }

  void _updateFromSmb(String ip, SmbIdentity? res) {
    if (res == null || _isCanceled) return;
    final updatedHosts = state.hosts.map((h) {
      if (h.ip == ip) {
        return h.copyWith(
          netbiosName: res.netbiosName ?? h.netbiosName,
          domain: res.domain ?? h.domain,
          hostname: res.dnsName ?? h.hostname,
          osVersion: res.nativeOs ?? h.osVersion,
          isDomainController: res.isDomainController || h.isDomainController,
        );
      }
      return h;
    }).toList();
    state = state.copyWith(hosts: updatedHosts);
    _fingerprintHost(ip, smbIdentity: res);
  }

  void _updateHostPorts(String ip, PortScanResult result) {
    if (result.state != PortState.open) return;

    final updatedHosts = state.hosts.map((h) {
      if (h.ip == ip) {
        final port = Port(
          port: result.port,
          protocol: 'tcp',
          state: 'open',
          banner: result.banner,
        );
        if (h.ports.any((p) => p.port == port.port)) return h;
        
        final newHost = h.copyWith(ports: [...h.ports, port]);
        
        // Trigger Domain Probe if LDAP port discovered
        if (port.port == 389 || port.port == 636) {
          _triggerDomainProbe(ip);
        }
        
        return newHost;
      }
      return h;
    }).toList();
    
    state = state.copyWith(hosts: updatedHosts);
    _fingerprintHost(ip);
  }

  Future<void> _triggerDomainProbe(String ip) async {
    try {
      final domainInfo = await DomainProbe.probeDomain(ip);
      if (domainInfo != null) {
        final updatedHosts = state.hosts.map((h) {
          if (h.ip == ip) {
            return h.copyWith(
              domainInfo: domainInfo,
              domain: domainInfo.domain ?? h.domain,
              hostname: domainInfo.dnsHostName ?? h.hostname,
              isDomainController: true,
            );
          }
          return h;
        }).toList();
        state = state.copyWith(hosts: updatedHosts);
        _fingerprintHost(ip);
      }
    } catch (e) {
      print('Domain probe failed for $ip: $e');
    }
  }

  void _fingerprintHost(String ip, {SmbIdentity? smbIdentity}) {
    final hostIndex = state.hosts.indexWhere((h) => h.ip == ip);
    if (hostIndex == -1) return;

    final host = state.hosts[hostIndex];
    final result = OsFingerprinter.detect(
      ttl: host.ttl,
      openPorts: host.ports.map((p) => p.port).toList(),
      hostname: host.hostname,
      netbiosName: host.netbiosName,
      nativeOs: smbIdentity?.nativeOs ?? host.osVersion,
      isDomainController: host.isDomainController,
    );

    final updatedHosts = List<Host>.from(state.hosts);
    updatedHosts[hostIndex] = host.copyWith(
      osType: result.osType,
      osVersion: result.osVersion ?? host.osVersion,
    );
    state = state.copyWith(hosts: updatedHosts);
  }

  void cancelScan() {
    _isCanceled = true;
    state = state.copyWith(status: DiscoveryStatus.idle, progress: 0);
  }

  void clearHistory() {
    state = DiscoveryState(status: DiscoveryStatus.idle);
  }
}

final discoverySessionProvider = StateNotifierProvider<DiscoverySessionNotifier, DiscoveryState>((ref) {
  return DiscoverySessionNotifier(ref);
});
