import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';
import 'package:flanexec/features/shared/models/reports.dart';

class SshEnumerator {
  static Future<SshPermissionReport?> getPermissions(
    String host, {
    int port = 22,
    required String username,
    String? password,
  }) async {
    try {
      final client = SSHClient(
        await SSHSocket.connect(host, port, timeout: const Duration(seconds: 5)),
        username: username,
        onPasswordRequest: () => password,
      );

      // Run 'id' to get UID/GID/Groups
      final idOutput = await client.run('id');
      final idStr = utf8.decode(idOutput, allowMalformed: true).trim();

      // uid=1000(user) gid=1000(user) groups=1000(user),4(adm),24(cdrom),...
      final uidMatch = RegExp(r'uid=(\d+)').firstMatch(idStr);
      final gidMatch = RegExp(r'gid=(\d+)').firstMatch(idStr);
      final groupsMatch = RegExp(r'groups=(.+)').firstMatch(idStr);

      final uid = uidMatch?.group(1) ?? 'unknown';
      final gid = gidMatch?.group(1) ?? 'unknown';
      final groups = groupsMatch?.group(1)?.split(',').map((e) => e.trim()).toList() ?? [];

      // Run 'sudo -n -l' to check for passwordless sudo
      List<String> sudoCommands = [];
      try {
        final sudoOutput = await client.run('sudo -n -l 2>/dev/null');
        final sudoStr = utf8.decode(sudoOutput, allowMalformed: true).trim();
        if (sudoStr.contains('User $username may run the following commands')) {
          final lines = sudoStr.split('\n');
          sudoCommands = lines.where((l) => l.trim().startsWith('(')).map((e) => e.trim()).toList();
        }
      } catch (_) {}

      client.close();

      return SshPermissionReport(
        uid: uid,
        gid: gid,
        groups: groups,
        sudoCommands: sudoCommands,
      );
    } catch (e) {
      return null;
    }
  }
}
