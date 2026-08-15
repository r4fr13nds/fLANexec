import 'dart:io';
import 'dart:async';

enum PingStatus { alive, unreachable, unknown }

class PingResult {
  final PingStatus status;
  final double? rttMs;
  final int? ttl;
  final int? respondedPort;
  final String method;

  PingResult({
    required this.status, 
    this.rttMs, 
    this.ttl, 
    this.respondedPort,
    this.method = 'icmp',
  });

  @override
  String toString() => 'PingResult(status: $status, rttMs: $rttMs, ttl: $ttl, port: $respondedPort, method: $method)';
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
        
        // On Windows, verify we actually got a reply from the target
        if (isWindows) {
          // A successful Windows ping reply MUST contain "TTL=" and "time"
          // If it contains "unreachable", "timed out", or lacks "TTL=", it's not a real response from the target.
          final hasTtl = output.contains('TTL=');
          final hasTime = output.contains('time');
          final isUnreachable = output.contains('unreachable');
          
          if (!hasTtl || !hasTime || isUnreachable || output.contains('100% loss')) {
            return PingResult(status: PingStatus.unreachable, method: 'icmp');
          }
          
          // Also verify the reply is actually from the target IP, not a local error message
          if (!output.contains(host)) {
            return PingResult(status: PingStatus.unreachable, method: 'icmp');
          }
        }

        final rtt = _parseRtt(output, isWindows);
        final ttl = _parseTtl(output);
        return PingResult(status: PingStatus.alive, rttMs: rtt, ttl: ttl, method: 'icmp');
      }
    } catch (_) {}

    return PingResult(status: PingStatus.unreachable, method: 'icmp');
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
    // Prioritizing definitive ports to speed up OS fingerprinting.
    // 445 (SMB), 135/139 (NetBIOS/RPC), 3389 (RDP) -> Strong Windows indicators
    // 22 (SSH) -> Strong Linux indicator
    // 80/443 -> Generic web ports
    final ports = [445, 135, 139, 3389, 22, 80, 443, 5353, 62078, 5555, 5000, 9100, 8009, 111, 2049];
    
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
          method: 'tcp',
        );
      } catch (_) {}
    }

    return PingResult(status: PingStatus.unknown, method: 'tcp');
  }
}
