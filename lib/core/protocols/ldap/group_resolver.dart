import 'package:flanexec/core/protocols/ldap/ldap_client.dart';
import 'package:flanexec/features/shared/models/reports.dart';

class LdapGroupResolver {
  static const List<String> _highPrivilegeGroups = [
    'Domain Admins',
    'Enterprise Admins',
    'Administrators',
    'Account Operators',
    'Server Operators',
    'Backup Operators',
    'Print Operators',
    'DnsAdmins',
    'Schema Admins',
  ];

  static Future<List<LdapGroupInfo>> getUserGroups(
    String host, {
    int port = 389,
    String? userDn,
    String? password,
    required String targetUser,
    bool useSsl = false,
  }) async {
    final client = LdapClient();
    try {
      await client.connect(host, port: port, useSsl: useSsl, timeout: const Duration(seconds: 5));
      await client.bind(dn: userDn, password: password);

      // 1. Find the user entry to get memberOf
      final searchFilter = '(|(sAMAccountName=$targetUser)(userPrincipalName=$targetUser))';
      final rootDse = await client.searchRootDse();
      final baseDn = rootDse?.attributes['defaultNamingContext']?.first ?? '';

      final userEntries = await client.search(baseDn, searchFilter, attributes: ['memberOf', 'cn']);
      if (userEntries.isEmpty) return [];

      final userEntry = userEntries.first;
      final groupDns = userEntry.attributes['memberOf'] ?? [];

      final List<LdapGroupInfo> groups = [];

      for (var groupDn in groupDns) {
        // Resolve group details
        final groupEntries = await client.search(groupDn, '(objectClass=*)', attributes: ['cn', 'description', 'member']);
        if (groupEntries.isNotEmpty) {
          final g = groupEntries.first;
          final name = g.attributes['cn']?.first ?? groupDn.split(',').first.replaceFirst('CN=', '');
          final description = g.attributes['description']?.first;
          final members = g.attributes['member'] ?? [];

          groups.add(LdapGroupInfo(
            name: name,
            dn: groupDn,
            description: description,
            memberCount: members.length,
            isHighPrivilege: _highPrivilegeGroups.any((hp) => name.contains(hp)),
          ));
        }
      }

      return groups;
    } catch (e) {
      return [];
    } finally {
      client.close();
    }
  }
}
