import 'dart:async';
import 'package:flanexec/core/networking/host_resolver.dart';
import 'package:flanexec/core/networking/ip_utils.dart';
import 'package:flanexec/core/networking/pinger.dart';
import 'package:flanexec/core/networking/port_scanner.dart';
import 'package:flanexec/core/protocols/ldap/domain_probe.dart';
import 'package:flanexec/features/discovery/providers/scan_config.dart';
import 'package:flanexec/features/shared/models/host.dart';
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
    final config = ref.read(scanConfigProvider);
    if (!IpUtils.isValidCidr(config.cidr)) {
      state = state.copyWith(status: DiscoveryStatus.error, error: 'Invalid CIDR');
      return;
    }

    _isCanceled = false;
    state = DiscoveryState(status: DiscoveryStatus.scanning);

    final ips = IpUtils.expandCidr(config.cidr);
    if (ips.isEmpty) {
      state = state.copyWith(status: DiscoveryStatus.done);
      return;
    }

    final total = ips.length;
    int processed = 0;
    
    final pool = Pool(config.concurrency);
    final List<Future> tasks = [];
    
    for (final ip in ips) {
      if (_isCanceled) break;

      tasks.add(pool.withResource(() async {
        if (_isCanceled) return;

        final targetIp = ip;
        try {
          state = state.copyWith(currentIp: targetIp);

          // 1. Ping Check
          final pingResult = await Pinger.ping(targetIp, timeout: Duration(seconds: config.timeoutSeconds));

          if (pingResult.status == PingStatus.alive) {
            // 2. Add host immediately with minimal info
            final initialHost = Host(
              ip: targetIp,
              status: 'alive',
              rttMs: pingResult.rttMs,
              lastSeen: DateTime.now(),
            );
            _addHost(initialHost);

            // 3. Resolve Hostname in background (we don't await this to keep scan moving)
            HostResolver.resolveHostname(targetIp).then((hostname) {
              if (hostname != null && !_isCanceled) {
                _updateHostName(targetIp, hostname);
              }
            }).catchError((_) {});

            // 4. Port Scan
            final scanStream = PortScanner.scanPorts(
              targetIp,
              config.ports,
              concurrency: 5,
              timeout: Duration(seconds: config.timeoutSeconds),
            );

            await for (final result in scanStream) {
              if (_isCanceled) break;
              _updateHostPorts(targetIp, result);
            }
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
  }

  void _addHost(Host host) {
    if (state.hosts.any((h) => h.ip == host.ip)) return;
    state = state.copyWith(hosts: [...state.hosts, host]);
  }

  void _updateHostName(String ip, String hostname) {
    final updatedHosts = state.hosts.map((h) {
      if (h.ip == ip) {
        return h.copyWith(hostname: hostname);
      }
      return h;
    }).toList();
    state = state.copyWith(hosts: updatedHosts);
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
  }

  Future<void> _triggerDomainProbe(String ip) async {
    try {
      final domainInfo = await DomainProbe.probeDomain(ip);
      if (domainInfo != null) {
        final updatedHosts = state.hosts.map((h) {
          if (h.ip == ip) {
            return h.copyWith(domainInfo: domainInfo);
          }
          return h;
        }).toList();
        state = state.copyWith(hosts: updatedHosts);
      }
    } catch (e) {
      print('Domain probe failed for $ip: $e');
    }
  }

  void cancelScan() {
    _isCanceled = true;
    state = state.copyWith(status: DiscoveryStatus.idle, progress: 0);
  }
}

final discoverySessionProvider = StateNotifierProvider<DiscoverySessionNotifier, DiscoveryState>((ref) {
  return DiscoverySessionNotifier(ref);
});
