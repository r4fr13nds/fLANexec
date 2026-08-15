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
    final osLower = nativeOs?.toLowerCase() ?? '';

    // 0. Strong String Indicators (Manual/Protocol override)
    if (osLower.contains('windows')) return FingerprintResult(HostOs.windows, osVersion: nativeOs);
    if (osLower.contains('linux') || osLower.contains('debian') || osLower.contains('ubuntu')) {
      return FingerprintResult(HostOs.linux, osVersion: nativeOs);
    }
    if (osLower.contains('macos') || osLower.contains('darwin')) return FingerprintResult(HostOs.macos, osVersion: nativeOs);

    // 1. TTL Check (High Confidence Fallback)
    // Move this up to prevent flickering when only common ports (80/443) are found
    if (ttl != null) {
      if (ttl >= 100 && ttl <= 129) {
        // High confidence Windows
        if (!openPorts.contains(22)) { // Unless we see SSH
          return FingerprintResult(HostOs.windows, osVersion: 'Windows (TTL 128)');
        }
      }
    }

    // 2. iOS Check (Strong indicators)
    if (openPorts.contains(62078) || hostLower.contains('iphone') || hostLower.contains('ipad')) {
      return FingerprintResult(HostOs.ios, osVersion: 'Apple iOS');
    }

    // 3. macOS Check (Strong indicators)
    final applePorts = {5900, 5000, 7000, 548, 631, 5353};
    final hasApplePort = openPorts.any((p) => applePorts.contains(p));
    final isAppleName = hostLower.contains('mac') || hostLower.contains('apple') || 
                        netbiosLower.contains('mac') || netbiosLower.contains('apple');
    
    if (hasApplePort || isAppleName) {
      if (!openPorts.contains(445) && !openPorts.contains(3389)) {
         return FingerprintResult(HostOs.macos, osVersion: 'Apple macOS');
      }
    }

    // 4. Windows Check (SMB/RPC/RDP/NetBIOS)
    final hasWindowsPorts = openPorts.contains(445) || openPorts.contains(3389) || 
                            openPorts.contains(135) || openPorts.contains(139);
    
    if (hasWindowsPorts) {
      return FingerprintResult(HostOs.windows, osVersion: isDomainController ? 'Windows Server (DC)' : 'Windows');
    }

    // 5. Android Check
    if (openPorts.contains(5555) || openPorts.contains(5037) || hostLower.contains('android')) {
      return FingerprintResult(HostOs.android, osVersion: 'Android');
    }

    // 6. Linux common ports
    final linuxPorts = {111, 2049, 3306, 5432, 6379}; // NFS, Portmap, DBs (Linux very strong)
    final webPorts = {21, 25, 80, 443, 8080}; // Generic (could be Windows or Linux)
    
    // SSH (22) is common on both now, so only use it if we don't have Windows indicators
    if (openPorts.contains(22) && !hasWindowsPorts) {
      if (ttl == null || ttl <= 64) {
        return FingerprintResult(HostOs.linux, osVersion: nativeOs ?? 'Linux (SSH)');
      }
    }

    if (openPorts.any((p) => linuxPorts.contains(p)) && !hasWindowsPorts) {
      return FingerprintResult(HostOs.linux, osVersion: nativeOs ?? 'Linux');
    }

    if (openPorts.any((p) => webPorts.contains(p))) {
      // If we only have generic web ports:
      if (ttl != null) {
        if (ttl >= 100) return FingerprintResult(HostOs.windows, osVersion: 'Windows (TTL 128)');
        if (ttl <= 64) return FingerprintResult(HostOs.linux, osVersion: 'Linux (Candidate)');
      }
      // If ttl is null (iOS), don't guess yet, stay unknown to avoid flickering
    }

    // 7. Network Device (Router/Switch/Printer)
    if (openPorts.contains(9100) || openPorts.contains(515) || hostLower.contains('router') || hostLower.contains('gateway')) {
      return FingerprintResult(HostOs.networkDevice, osVersion: 'Network Device');
    }

    // Final TTL Fallback
    if (ttl != null) {
      if (ttl >= 60 && ttl <= 66) {
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
