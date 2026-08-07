import 'dart:io';
import 'dart:async';

enum PingStatus { alive, unreachable, unknown }

class PingResult {
  final PingStatus status;
  final double? rttMs;
  final int? ttl;

  PingResult({required this.status, this.rttMs, this.ttl});

  @override
  String toString() => 'PingResult(status: $status, rttMs: $rttMs, ttl: $ttl)';
}

class Pinger {
  static Future<PingResult> ping(String host, {Duration timeout = const Duration(seconds: 2)}) async {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return _pingDesktop(host, timeout);
    } else {
      return _pingMobileFallback(host, timeout);
    }
  }

  static Future<PingResult> _pingDesktop(String host, Duration timeout) async {
    final isWindows = Platform.isWindows;
    final isMac = Platform.isMacOS;
    final String executable = 'ping';
    
    final List<String> arguments = isWindows
        ? ['-n', '1', '-w', timeout.inMilliseconds.toString(), host]
        : (isMac 
            ? ['-c', '1', '-W', timeout.inMilliseconds.toString(), host]
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
    final ports = [80, 443, 7, 22, 135, 445];
    
    final stopwatch = Stopwatch()..start();
    for (var port in ports) {
      try {
        final socket = await Socket.connect(host, port, timeout: Duration(milliseconds: 500));
        socket.destroy();
        stopwatch.stop();
        return PingResult(status: PingStatus.alive, rttMs: stopwatch.elapsedMilliseconds.toDouble());
      } catch (_) {}
    }

    return PingResult(status: PingStatus.unknown);
  }
}
