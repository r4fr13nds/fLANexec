import 'package:flanexec/features/shared/models/host.dart';

class FingerprintResult {
  final HostOs osType;
  final String? osVersion;

  FingerprintResult(this.osType, {this.osVersion});
}

class OsFingerprinter {
  static FingerprintResult detect({
    int? ttl,
    required List<int> openPorts,
    String? hostname,
    String? netbiosName,
    String? nativeOs,
    bool isDomainController = false,
  }) {
    final hostLower = hostname?.toLowerCase() ?? '';
    final netbiosLower = netbiosName?.toLowerCase() ?? '';

    // 1. iOS Check (Strong indicators)
    if (openPorts.contains(62078) || hostLower.contains('iphone') || hostLower.contains('ipad')) {
      return FingerprintResult(HostOs.ios, osVersion: 'Apple iOS');
    }

    // 2. macOS Check (Strong indicators)
    final applePorts = {5900, 5000, 7000, 548, 631, 5353};
    final hasApplePort = openPorts.any((p) => applePorts.contains(p));
    final isAppleName = hostLower.contains('mac') || hostLower.contains('apple') || 
                        netbiosLower.contains('mac') || netbiosLower.contains('apple');
    
    if (hasApplePort || isAppleName) {
      // If it looks like Apple and doesn't have Windows-only ports, it's macOS
      if (!openPorts.contains(445) && !openPorts.contains(3389)) {
         return FingerprintResult(HostOs.macos, osVersion: 'Apple macOS');
      }
    }

    // 3. Android Check
    if (openPorts.contains(5555) || openPorts.contains(5037) || hostLower.contains('android')) {
      return FingerprintResult(HostOs.android, osVersion: 'Android');
    }

    // 4. Windows Check (SMB/RPC/RDP/NetBIOS)
    if (nativeOs?.toLowerCase().contains('windows') ?? false) {
      return FingerprintResult(HostOs.windows, osVersion: nativeOs);
    }
    
    if (openPorts.contains(445) || openPorts.contains(3389) || openPorts.contains(135)) {
      return FingerprintResult(HostOs.windows, osVersion: isDomainController ? 'Windows Server (DC)' : 'Windows');
    }

    // 5. Linux common ports (High probability)
    final linuxPorts = {21, 22, 25, 80, 111, 443, 2049, 3306, 5432, 6379, 8080};
    if (openPorts.any((p) => linuxPorts.contains(p))) {
      // If it has standard ports but no Windows indicators
      if (!openPorts.contains(3389) && !openPorts.contains(135)) {
        String version = nativeOs ?? 'Linux';
        // Clean up common technical OS strings
        if (version.toLowerCase().contains('unix')) version = 'Linux';
        if (version.toLowerCase().contains('samba')) version = 'Linux (Samba)';
        
        return FingerprintResult(HostOs.linux, osVersion: version);
      }
    }

    // 6. Network Device (Router/Switch/Printer)
    if (openPorts.contains(9100) || openPorts.contains(515) || hostLower.contains('router') || hostLower.contains('gateway')) {
      return FingerprintResult(HostOs.networkDevice, osVersion: 'Network Device');
    }

    // 7. TTL Check (Last resort fallback)
    if (ttl != null) {
      if (ttl >= 100 && ttl <= 129) {
        return FingerprintResult(HostOs.windows, osVersion: 'Windows (TTL 128)');
      } else if (ttl >= 60 && ttl <= 66) {
        // macOS and Linux both use ~64. 
        // If we have no ports yet, don't guess Linux immediately to avoid flickering
        if (openPorts.isNotEmpty) {
          return FingerprintResult(HostOs.linux, osVersion: 'Linux');
        }
      } else if (ttl >= 250 && ttl <= 255) {
        return FingerprintResult(HostOs.networkDevice);
      }
    }

    return FingerprintResult(HostOs.unknown);
  }
}
