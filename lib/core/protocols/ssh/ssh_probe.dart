import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';

class SshAuthResult {
  final bool success;
  final String? banner;
  final String? error;

  SshAuthResult({required this.success, this.banner, this.error});
}

class SshProbe {
  static Future<SshAuthResult> authenticate(
    String host, {
    int port = 22,
    required String username,
    String? password,
    String? keyFile,
  }) async {
    try {
      final client = SSHClient(
        await SSHSocket.connect(host, port, timeout: const Duration(seconds: 5)),
        username: username,
        onPasswordRequest: () => password,
      );

      // If we reach here, it's authenticated (or partially so)
      final banner = client.remoteVersion;
      client.close();
      return SshAuthResult(success: true, banner: banner);
    } catch (e) {
      return SshAuthResult(success: false, error: e.toString());
    }
  }

  static Future<String?> runCommand(
    String host, {
    int port = 22,
    required String username,
    String? password,
    required String command,
  }) async {
    try {
      final client = SSHClient(
        await SSHSocket.connect(host, port, timeout: const Duration(seconds: 5)),
        username: username,
        onPasswordRequest: () => password,
      );

      final result = await client.run(command);
      client.close();
      return utf8.decode(result, allowMalformed: true);
    } catch (_) {
      return null;
    }
  }
}
