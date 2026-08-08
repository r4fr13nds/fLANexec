import 'dart:io';
import 'package:flanexec/core/protocols/ldap/domain_probe.dart';
import 'package:flanexec/core/protocols/ldap/group_resolver.dart';
import 'package:flanexec/core/protocols/smb/enumerator.dart';
import 'package:flanexec/core/protocols/smb/smb_client.dart';
import 'package:flanexec/core/protocols/smb/smb_dart.dart';
import 'package:flanexec/core/protocols/ssh/ssh_probe.dart';
import 'package:flanexec/core/protocols/ssh/enumerator.dart';
import 'package:flanexec/core/protocols/winrm/enumerator.dart';
import 'package:flanexec/core/utils/logger.dart';
import 'package:flanexec/features/credentials/models/credential_set.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthSessionNotifier extends StateNotifier<Map<String, Map<String, AuthResultMatrix>>> {
  AuthSessionNotifier(this.ref) : super({});

  final Ref ref;

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
        ref.read(loggerProvider.notifier).log(host, 'Auth ${res.success == true ? 'Success' : 'Failed'} (${protocol.name.toUpperCase()})');
        state[host]![cred.id] = res;
        state = {...state};
      });
    }
  }

  Future<void> runEnumeration(String host, CredentialSet cred, String type) async {
    final current = state[host]?[cred.id];
    if (current == null) return;

    // Update state to loading for this specific action
    state[host]![cred.id] = current.copyWith(info: 'Running $type...');
    state = {...state};

    try {
      dynamic report;
      if (type == 'shares') {
        report = await SmbEnumerator.enumerateAccessibleShares(
          host,
          username: cred.username,
          password: cred.password ?? '',
          domain: cred.domain,
        );
      } else if (type == 'permissions') {
        if (current.protocol == 'ssh') {
          report = await SshEnumerator.getPermissions(
            host,
            username: cred.username,
            password: cred.password,
          );
        } else if (current.protocol == 'winrm') {
          report = await WinrmEnumerator.getPermissions(
            host,
            username: cred.username,
            password: cred.password ?? '',
            domain: cred.domain,
          );
        }
      } else if (type == 'groups') {
        report = await LdapGroupResolver.getUserGroups(
          host,
          userDn: cred.username,
          password: cred.password,
          targetUser: cred.username,
        );
      }

      if (report != null) {
        final Map<String, dynamic> data = {...(current.reportData ?? {})};
        data[type] = report;
        state[host]![cred.id] = current.copyWith(
          info: '$type completed',
          reportData: data,
        );
      } else {
        state[host]![cred.id] = current.copyWith(info: '$type failed');
      }
    } catch (e) {
      state[host]![cred.id] = current.copyWith(info: '$type error: $e');
    }
    state = {...state};
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
  return AuthSessionNotifier(ref);
});
