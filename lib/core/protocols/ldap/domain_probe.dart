import 'package:flanexec/core/protocols/ldap/ldap_client.dart';
import 'package:flanexec/core/protocols/ldap/models/domain_info.dart';

class DomainProbe {
  static Future<DomainInfo?> probeDomain(String host, {int port = 389, bool useSsl = false}) async {
    final client = LdapClient();
    try {
      await client.connect(host, port: port, useSsl: useSsl, timeout: const Duration(seconds: 3));
      await client.bind(); // Anonymous bind

      final rootDse = await client.searchRootDse();
      if (rootDse == null) return null;

      final attrs = rootDse.attributes;

      return DomainInfo(
        domain: _getFirst(attrs['defaultNamingContext']),
        forest: _getFirst(attrs['rootDomainNamingContext']),
        dnsHostName: _getFirst(attrs['dnsHostName']),
        serverDn: _getFirst(attrs['serverName']),
        isGlobalCatalog: _getFirst(attrs['isGlobalCatalogReady']) == 'TRUE',
        functionalLevel: int.tryParse(_getFirst(attrs['domainControllerFunctionality']) ?? ''),
        supportedMechs: attrs['supportedSASLMechanisms'] ?? [],
      );
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  static String? _getFirst(List<String>? list) {
    if (list == null || list.isEmpty) return null;
    return list.first;
  }
}
