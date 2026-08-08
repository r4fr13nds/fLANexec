import 'dart:io';
import 'dart:async';

enum PingStatus { alive, unreachable, unknown }

class PingResult {
  final PingStatus status;
  final double? rttMs;
  final int? ttl;
  final int? respondedPort;

  PingResult({required this.status, this.rttMs, this.ttl, this.respondedPort});

  @override
  String toString() => 'PingResult(status: $status, rttMs: $rttMs, ttl: $ttl, port: $respondedPort)';
}

class Pinger {
  static Future<PingResult> ping(String host, {Duration timeout = const Duration(seconds: 2)}) async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      final res = await _pingDesktop(host, timeout);
      if (res.status == PingStatus.alive) return res;
      // Fallback to TCP if ICMP ping failed or was blocked by OS
      return _pingMobileFallback(host, timeout);
    } else {
      return _pingMobileFallback(host, timeout);
    }
  }

  static Future<PingResult> _pingDesktop(String host, Duration timeout) async {
    final isWindows = Platform.isWindows;
    final isMac = Platform.isMacOS;
    
    // Explicit full path to utility on macOS
    final String executable = isMac ? '/sbin/ping' : 'ping';
    
    // Arguments for single packet with timeout
    final List<String> arguments = isWindows
        ? ['-n', '1', '-w', timeout.inMilliseconds.toString(), host]
        : (isMac 
            ? ['-c', '1', '-W', '1000', host] // macOS ping -W is milliseconds
            : ['-c', '1', '-W', timeout.inSeconds.toString(), host]);

    try {
      final result = await Process.run(executable, arguments);
      if (result.exitCode == 0) {
        final output = result.stdout.toString();
        final rtt = _parseRtt(output, isWindows);
        final ttl = _parseTtl(output);
        return PingResult(status: PingStatus.alive, rttMs: rtt, ttl: ttl);
      }
    } catch (_) {}

    return PingResult(status: PingStatus.unreachable);
  }

  static double? _parseRtt(String output, bool isWindows) {
    try {
      if (isWindows) {
        // Average = 1ms, Minimum = 1ms, Maximum = 1ms
        final match = RegExp(r'Average = (\d+)ms').firstMatch(output);
        if (match != null) return double.tryParse(match.group(1)!);
      } else {
        // 64 bytes from ... time=0.045 ms
        final match = RegExp(r'time=([\d.]+)').firstMatch(output);
        if (match != null) return double.tryParse(match.group(1)!);
      }
    } catch (_) {}
    return null;
  }

  static int? _parseTtl(String output) {
    try {
      final match = RegExp(r'TTL=(\d+)', caseSensitive: false).firstMatch(output);
      if (match != null) return int.tryParse(match.group(1)!);
    } catch (_) {}
    return null;
  }

  static Future<PingResult> _pingMobileFallback(String host, Duration timeout) async {
    // Mobile often blocks ICMP. Fallback to TCP connect on common ports.
    // Added 5353 (mDNS), 62078 (iOS), 5555 (ADB), 5000 (AirPlay), 139 (NetBIOS), 9100 (Printer), 8009 (Cast)
    final ports = [80, 443, 22, 445, 139, 135, 5353, 62078, 5555, 5000, 9100, 8009, 111, 2049];
    
    final stopwatch = Stopwatch()..start();
    for (var port in ports) {
      try {
        final socket = await Socket.connect(host, port, timeout: Duration(milliseconds: 400));
        socket.destroy();
        stopwatch.stop();
        return PingResult(
          status: PingStatus.alive, 
          rttMs: stopwatch.elapsedMilliseconds.toDouble(),
          respondedPort: port,
        );
      } catch (_) {}
    }

    return PingResult(status: PingStatus.unknown);
  }
}
