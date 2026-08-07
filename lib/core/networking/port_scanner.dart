import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:pool/pool.dart';

enum PortState { open, closed, filtered }

class PortScanResult {
  final String host;
  final int port;
  final PortState state;
  final String? banner;

  PortScanResult({
    required this.host,
    required this.port,
    required this.state,
    this.banner,
  });

  @override
  String toString() => 'PortScanResult($host:$port, $state, banner: $banner)';
}

class PortScanner {
  static Stream<PortScanResult> scanPorts(
    String host,
    List<int> ports, {
    int concurrency = 50,
    Duration timeout = const Duration(seconds: 2),
  }) async* {
    final pool = Pool(concurrency);
    final controller = StreamController<PortScanResult>();

    final futures = <Future>[];

    for (var port in ports) {
      futures.add(pool.withResource(() async {
        final result = await _scanSinglePort(host, port, timeout);
        controller.add(result);
      }));
    }

    // We don't want to block the stream, so we run the wait in background
    // and close the controller when done.
    unawaited(Future.wait(futures).then((_) => controller.close()));

    yield* controller.stream;
  }

  static Future<PortScanResult> _scanSinglePort(String host, int port, Duration timeout) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      
      String? banner;
      try {
        banner = await _grabBanner(socket, port);
      } catch (_) {
        // Banner grab failed, but port is still open
      } finally {
        try {
          socket.destroy();
        } catch (_) {}
      }

      return PortScanResult(
        host: host,
        port: port,
        state: PortState.open,
        banner: banner,
      );
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 61 || e.osError?.errorCode == 111 || e.osError?.errorCode == 1225) {
        return PortScanResult(host: host, port: port, state: PortState.closed);
      }
      return PortScanResult(host: host, port: port, state: PortState.filtered);
    } catch (_) {
      return PortScanResult(host: host, port: port, state: PortState.filtered);
    }
  }

  static Future<String?> _grabBanner(Socket socket, int port) async {
    final completer = Completer<String?>();
    
    // Probes - wrap in try-catch to handle immediate resets
    try {
      if (port == 80 || port == 8080 || port == 443) {
        socket.write('GET / HTTP/1.0\r\n\r\n');
      } else if (port == 21) {
        // FTP - usually server speaks first
      } else if (port == 22) {
        // SSH - server speaks first
      } else if (port == 25) {
        // SMTP - server speaks first
      }
    } catch (_) {
      // Socket might have closed immediately
    }

    final subscription = socket.listen(
      (data) {
        if (!completer.isCompleted) {
          final text = utf8.decode(data, allowMalformed: true).trim();
          final banner = text.length > 512 ? text.substring(0, 512) : text;
          completer.complete(banner);
        }
      },
      onError: (_) {
        if (!completer.isCompleted) completer.complete(null);
      },
      onDone: () {
        if (!completer.isCompleted) completer.complete(null);
      },
      cancelOnError: true,
    );

    // Timeout for banner grab
    Timer(const Duration(milliseconds: 500), () {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
      subscription.cancel();
    });

    return completer.future;
  }
}
