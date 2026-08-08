import 'package:flanexec/core/protocols/smb/smb_client.dart';
import 'package:flanexec/features/shared/models/reports.dart';

class SmbEnumerator {
  static Future<List<ShareAccessReport>> enumerateAccessibleShares(
    String host, {
    required String username,
    required String password,
    String? domain,
  }) async {
    final client = PlatformSmbClient();
    try {
      final shares = await client.enumerateShares(
        host,
        username: username,
        password: password,
        domain: domain,
      );

      final List<ShareAccessReport> reports = [];

      for (var share in shares) {
        String accessLevel = 'DENIED';
        List<String> samples = [];
        int count = 0;

        try {
          final entries = await client.listShare(
            host,
            username: username,
            password: password,
            shareName: share.name,
            domain: domain,
          );
          if (entries.isNotEmpty) {
            accessLevel = 'READ';
            count = entries.length;
            samples = entries.take(5).map((e) => e.name).toList();
            
            // Try write check
            final writeResult = await client.checkWriteAccess(
              host,
              username: username,
              password: password,
              shareName: share.name,
              domain: domain,
            );
            if (writeResult.writable) {
              accessLevel = 'WRITE';
            }
          }
        } catch (_) {}

        reports.add(ShareAccessReport(
          shareName: share.name,
          accessLevel: accessLevel,
          itemCount: count,
          sampleFiles: samples,
        ));
      }

      return reports;
    } catch (e) {
      return [];
    }
  }
}
