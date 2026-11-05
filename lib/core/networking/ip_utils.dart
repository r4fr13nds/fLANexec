import 'dart:io';

class IpUtils {
  /// Returns the first non-loopback IPv4 address found on the device.
  static Future<String?> getLocalIpAddress() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      
      // Priority list for private IP ranges
      final priorityRanges = ['192.168.', '10.', '172.'];
      
      for (var range in priorityRanges) {
        for (var interface in interfaces) {
          for (var addr in interface.addresses) {
            final ip = addr.address;
            if (ip.startsWith(range)) {
              if (range == '172.' && !_isPrivateStat(ip)) continue;
              return ip;
            }
          }
        }
      }
      
      if (interfaces.isNotEmpty) {
        for (var interface in interfaces) {
          if (interface.addresses.isNotEmpty) {
            return interface.addresses.first.address;
          }
        }
      }
    } catch (_) {
      // Interface enumeration can fail on restricted platforms.
    }
    return null;
  }

  static bool _isPrivateStat(String ip) {
    final parts = ip.split('.');
    if (parts.length < 2) return false;
    final second = int.tryParse(parts[1]) ?? 0;
    return second >= 16 && second <= 31;
  }

  /// Infers the CIDR from a local IP.
  /// On Desktop, it tries to find the actual netmask from the interface.
  /// Defaults to /24 if not found or on mobile.
  static Future<String> inferCidrFromLocalIp(String ip) async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.address == ip) {
            // Some platforms might provide netmask info in the future or via platform specific logic.
            // For now, we fallback to /24 unless we can determine it.
            // In dart:io, InternetAddress doesn't directly expose the netmask.
            return '$ip/24';
          }
        }
      }
    } catch (_) {}
    return '$ip/24';
  }

  static bool isValidIp(String input) {
    try {
      final addr = InternetAddress(input);
      return addr.type == InternetAddressType.IPv4;
    } catch (_) {
      return false;
    }
  }

  static bool isValidCidr(String input) {
    final parts = input.split('/');
    if (parts.length != 2) return false;
    if (!isValidIp(parts[0])) return false;
    final prefix = int.tryParse(parts[1]);
    return prefix != null && prefix >= 0 && prefix <= 32;
  }

  static int ipToUint32(String ip) {
    final parts = ip.split('.').map(int.parse).toList();
    return (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8) | parts[3];
  }

  static String uint32ToIp(int value) {
    return [
      (value >> 24) & 0xFF,
      (value >> 16) & 0xFF,
      (value >> 8) & 0xFF,
      value & 0xFF,
    ].join('.');
  }

  /// Expands a CIDR string into a list of IP addresses.
  /// Skips network and broadcast addresses for /24 and larger.
  /// Caps at 65536 IPs.
  static List<String> expandCidr(String cidr) {
    if (!isValidCidr(cidr)) return [];

    final parts = cidr.split('/');
    final baseIp = parts[0];
    final prefix = int.parse(parts[1]);

    if (prefix < 16) {
      // Safety cap to avoid OOM for very large networks
      // A /16 is 65536 IPs.
      // We could support more, but for a mobile-first app, this is a reasonable start.
    }

    final int ipInt = ipToUint32(baseIp);
    final int mask = prefix == 0 ? 0 : (0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF;
    final int network = ipInt & mask;
    final int numHosts = 1 << (32 - prefix);

    // Limit to 65536 hosts
    final int actualHosts = numHosts > 65536 ? 65536 : numHosts;

    final List<String> ips = [];
    for (int i = 0; i < actualHosts; i++) {
      final currentIp = network + i;
      
      // For /24 (and prefix <= 30), it's conventional to skip .0 and .255
      // But for /31 and /32, all IPs are usable.
      if (prefix <= 30) {
        if (i == 0 || i == numHosts - 1) continue;
      }
      
      ips.add(uint32ToIp(currentIp));
    }

    return ips;
  }
}
