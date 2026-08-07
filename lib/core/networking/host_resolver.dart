import 'dart:io';

class HostResolver {
  static Future<String?> resolveHostname(String ip) async {
    // 1. Try Reverse DNS
    try {
      final address = InternetAddress(ip);
      final result = await address.reverse();
      if (result.host != ip) {
        return result.host;
      }
    } catch (_) {}

    // 2. Try mDNS fallback for common services
    try {
      final mdnsHostname = await _resolveViaMdns(ip);
      if (mdnsHostname != null) return mdnsHostname;
    } catch (_) {}

    return null;
  }

  static Future<String?> _resolveViaMdns(String targetIp) async {
    // DISABLING mDNS TEMPORARILY: This is causing SocketExceptions (errno 65) 
    // and VM crashes on some macOS network configurations.
    return null;
  }
}
