import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flanexec/core/networking/models/service_info.dart';
import 'package:flanexec/core/networking/pinger.dart';

class ServiceDetector {
  static Future<ServiceInfo> probe(String host, int port, {Duration timeout = const Duration(seconds: 5)}) async {
    int? ttl;
    try {
      final ping = await Pinger.ping(host, timeout: timeout);
      if (ping.status == PingStatus.alive) {
        ttl = ping.ttl;
      }
    } catch (_) {}

    ServiceInfo info;
    try {
      switch (port) {
        case 22:
          info = await _probeSSH(host, port, timeout);
          break;
        case 80:
        case 8080:
        case 443:
          info = await _probeHTTP(host, port, timeout);
          break;
        case 21:
          info = await _probeFTP(host, port, timeout);
          break;
        case 25:
        case 587:
          info = await _probeSMTP(host, port, timeout);
          break;
        case 53:
          info = await _probeDNS(host, port, timeout);
          break;
        case 445:
        case 139:
          info = await _probeSMB(host, port, timeout);
          break;
        default:
          info = await _probeGeneric(host, port, timeout);
      }
    } catch (e) {
      info = ServiceInfo(
        host: host,
        port: port,
        service: 'unknown',
        rawOutput: 'Error during probe: $e',
      );
    }

    if (info.osGuess == null && ttl != null) {
      String? os;
      if (ttl <= 64) {
        os = 'Linux/macOS';
      } else if (ttl <= 128) {
        os = 'Windows';
      } else {
        os = 'Network Device';
      }
      return info.copyWith(osGuess: os);
    }

    return info;
  }

  static Future<ServiceInfo> _probeSSH(String host, int port, Duration timeout) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      final completer = Completer<String>();
      
      socket.listen((data) {
        if (!completer.isCompleted) {
          completer.complete(utf8.decode(data, allowMalformed: true).trim());
        }
        socket.destroy();
      }, onError: (e) {
        if (!completer.isCompleted) completer.completeError(e);
      }, onDone: () {
        if (!completer.isCompleted) completer.complete('');
      });

      final banner = await completer.future.timeout(const Duration(seconds: 2));
      
      String? product;
      String? version;
      if (banner.contains('OpenSSH')) {
        product = 'OpenSSH';
        final match = RegExp(r'OpenSSH_([\d.p\w]+)').firstMatch(banner);
        version = match?.group(1);
      }

      return ServiceInfo(
        host: host,
        port: port,
        service: 'ssh',
        product: product,
        version: version,
        rawOutput: banner,
        osGuess: banner.contains('Ubuntu') ? 'Ubuntu Linux' : (banner.contains('Debian') ? 'Debian Linux' : null),
      );
    } catch (e) {
      return _probeGeneric(host, port, timeout);
    }
  }

  static Future<ServiceInfo> _probeHTTP(String host, int port, Duration timeout) async {
    try {
      final client = HttpClient()..connectionTimeout = timeout;
      final scheme = port == 443 ? 'https' : 'http';
      final request = await client.getUrl(Uri.parse('$scheme://$host:$port/'));
      final response = await request.close();
      
      final server = response.headers.value('server');
      final poweredBy = response.headers.value('x-powered-by');
      
      final body = await response.transform(utf8.decoder).join();
      final titleMatch = RegExp(r'<title>(.*?)</title>', caseSensitive: false).firstMatch(body);
      final title = titleMatch?.group(1);

      final buffer = StringBuffer();
      buffer.writeln('HTTP ${response.statusCode} ${response.reasonPhrase}');
      response.headers.forEach((name, values) {
        buffer.writeln('$name: ${values.join(', ')}');
      });

      return ServiceInfo(
        host: host,
        port: port,
        service: scheme,
        product: server?.split('/').first,
        version: server?.contains('/') == true ? server!.split('/').last : null,
        extraInfo: poweredBy != null ? 'Powered by $poweredBy' : null,
        scripts: {
          'http-title': title,
        }.entries.where((e) => e.value != null).fold<Map<String, String>>({}, (m, e) {
          m[e.key] = e.value!;
          return m;
        }),
        rawOutput: buffer.toString(),
      );
    } catch (e) {
      return _probeGeneric(host, port, timeout);
    }
  }

  static Future<ServiceInfo> _probeFTP(String host, int port, Duration timeout) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      final completer = Completer<String>();
      
      socket.listen((data) {
        if (!completer.isCompleted) {
          completer.complete(utf8.decode(data).trim());
        }
        socket.destroy();
      });

      final banner = await completer.future.timeout(const Duration(seconds: 2));
      return ServiceInfo(
        host: host,
        port: port,
        service: 'ftp',
        rawOutput: banner,
        product: banner.contains('vsFTPd') ? 'vsFTPd' : null,
      );
    } catch (e) {
      return _probeGeneric(host, port, timeout);
    }
  }

  static Future<ServiceInfo> _probeSMTP(String host, int port, Duration timeout) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      final completer = Completer<String>();
      final buffer = StringBuffer();
      
      socket.listen((data) {
        final text = utf8.decode(data);
        buffer.write(text);
        if (text.contains('220 ') && !completer.isCompleted) {
          socket.write('EHLO flanexec.local\r\n');
        }
        if (text.contains('250 ') && !completer.isCompleted) {
          completer.complete(buffer.toString());
          socket.destroy();
        }
      }, onError: (e) => completer.completeError(e));

      final output = await completer.future.timeout(const Duration(seconds: 3));
      return ServiceInfo(
        host: host,
        port: port,
        service: 'smtp',
        rawOutput: output,
      );
    } catch (e) {
      return _probeGeneric(host, port, timeout);
    }
  }

  static Future<ServiceInfo> _probeDNS(String host, int port, Duration timeout) async {
    try {
      // Basic DNS version probe via UDP
      final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      
      // version.bind CHAOS TXT query
      final query = [
        0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x07, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x04, 0x62, 0x69, 0x6e, 0x64, 0x00,
        0x00, 0x10, 0x00, 0x03
      ];
      
      socket.send(query, InternetAddress(host), port);
      
      final completer = Completer<ServiceInfo>();
      socket.listen((event) {
        if (event == RawSocketEvent.read) {
          final dg = socket.receive();
          if (dg != null) {
            completer.complete(ServiceInfo(
              host: host,
              port: port,
              service: 'dns',
              rawOutput: 'Received UDP response (${dg.data.length} bytes)',
              extraInfo: 'Responded to version.bind query',
            ));
          }
        }
      });

      return await completer.future.timeout(const Duration(seconds: 2));
    } catch (e) {
      return ServiceInfo(host: host, port: port, service: 'dns', rawOutput: 'UDP probe failed: $e');
    }
  }

  static Future<ServiceInfo> _probeSMB(String host, int port, Duration timeout) async {
    // SMB is complex, for Step 4 we do a basic TCP-level OS guess or just banner
    // Real SMB negotiation would happen via platform channels in Step 6.
    return ServiceInfo(
      host: host,
      port: port,
      service: 'microsoft-ds',
      product: 'Microsoft Windows SMB',
      osGuess: 'Windows',
      rawOutput: 'SMB port open. Requires platform-specific auth for deep probe.',
    );
  }

  static Future<ServiceInfo> _probeGeneric(String host, int port, Duration timeout) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      final completer = Completer<String>();
      
      socket.listen((data) {
        if (!completer.isCompleted) {
          completer.complete(utf8.decode(data, allowMalformed: true).trim());
        }
        socket.destroy();
      }, onError: (e) {
        if (!completer.isCompleted) completer.complete('');
      }, onDone: () {
        if (!completer.isCompleted) completer.complete('');
      });

      // Send a newline to trigger some services - wrap in try to catch resets
      try {
        socket.write('\r\n');
      } catch (_) {}

      final banner = await completer.future.timeout(const Duration(seconds: 1), onTimeout: () => '');
      
      return ServiceInfo(
        host: host,
        port: port,
        service: _guessServiceByPort(port),
        rawOutput: banner.isEmpty ? '(No banner received)' : banner,
      );
    } catch (e) {
      return ServiceInfo(
        host: host,
        port: port,
        service: _guessServiceByPort(port),
        rawOutput: 'Connection failed: $e',
      );
    }
  }

  static String _guessServiceByPort(int port) {
    final common = {
      21: 'ftp', 22: 'ssh', 23: 'telnet', 25: 'smtp', 53: 'dns',
      80: 'http', 110: 'pop3', 139: 'netbios-ssn', 143: 'imap',
      443: 'https', 445: 'microsoft-ds', 3306: 'mysql', 3389: 'ms-wbt-server',
      5432: 'postgresql', 8080: 'http-proxy'
    };
    return common[port] ?? 'unknown';
  }
}
