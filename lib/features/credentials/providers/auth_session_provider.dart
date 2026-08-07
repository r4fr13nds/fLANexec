import 'dart:io';
import 'package:flanexec/core/protocols/ldap/domain_probe.dart';
import 'package:flanexec/core/protocols/smb/smb_client.dart';
import 'package:flanexec/core/protocols/smb/smb_dart.dart';
import 'package:flanexec/core/protocols/ssh/ssh_probe.dart';
import 'package:flanexec/features/credentials/models/credential_set.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthSessionNotifier extends StateNotifier<Map<String, Map<String, AuthResultMatrix>>> {
  AuthSessionNotifier() : super({});

  Future<void> checkAccess(List<String> hosts, CredentialSet cred, CredentialType protocol) async {
    final Map<String, Map<String, AuthResultMatrix>> results = {...state};
    
    for (final host in hosts) {
      if (!results.containsKey(host)) results[host] = {};
      
      results[host]![cred.id] = AuthResultMatrix(
        host: host,
        credentialId: cred.id,
        protocol: protocol.name,
        success: null,
        info: 'Checking...',
      );
      state = {...results};

      _performAuth(host, cred, protocol).then((res) {
        state[host]![cred.id] = res;
        state = {...state};
      });
    }
  }

  Future<AuthResultMatrix> _performAuth(String host, CredentialSet cred, CredentialType protocol) async {
    try {
      switch (protocol) {
        case CredentialType.ssh:
          final res = await SshProbe.authenticate(
            host,
            username: cred.username,
            password: cred.password,
          );
          return AuthResultMatrix(
            host: host,
            credentialId: cred.id,
            protocol: 'ssh',
            success: res.success,
            info: res.success ? res.banner : res.error,
          );
        case CredentialType.smb:
          if (Platform.isIOS) {
            final res = await SmbDartClient.authenticate(
              host,
              username: cred.username,
              password: cred.password ?? '',
              domain: cred.domain,
            );
            return AuthResultMatrix(
              host: host,
              credentialId: cred.id,
              protocol: 'smb',
              success: res.success,
              info: res.success ? res.osVersion : res.error,
            );
          }
          
          final smb = PlatformSmbClient();
          final res = await smb.authenticate(
            host,
            username: cred.username,
            password: cred.password ?? '',
            domain: cred.domain,
          );
          return AuthResultMatrix(
            host: host,
            credentialId: cred.id,
            protocol: 'smb',
            success: res.success,
            info: res.success ? res.osVersion : res.error,
          );
        case CredentialType.ldap:
          final res = await DomainProbe.probeDomain(host);
          return AuthResultMatrix(
            host: host,
            credentialId: cred.id,
            protocol: 'ldap',
            success: res != null,
            info: res != null ? 'Forest: ${res.forest}' : 'Probe failed',
          );
        default:
          return AuthResultMatrix(
            host: host,
            credentialId: cred.id,
            protocol: protocol.name,
            success: false,
            info: 'Not implemented',
          );
      }
    } catch (e) {
      return AuthResultMatrix(
        host: host,
        credentialId: cred.id,
        protocol: protocol.name,
        success: false,
        info: e.toString(),
      );
    }
  }
}

final authSessionProvider = StateNotifierProvider<AuthSessionNotifier, Map<String, Map<String, AuthResultMatrix>>>((ref) {
  return AuthSessionNotifier();
});
