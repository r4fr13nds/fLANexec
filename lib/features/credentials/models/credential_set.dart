import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_set.freezed.dart';
part 'credential_set.g.dart';

enum CredentialType { smb, winrm, ssh, ldap }

@freezed
class CredentialSet with _$CredentialSet {
  const factory CredentialSet({
    required String id,
    required String name,
    required String username,
    String? password,
    String? domain,
    String? hash,
    String? privateKey,
  }) = _CredentialSet;

  factory CredentialSet.fromJson(Map<String, dynamic> json) => _$CredentialSetFromJson(json);
}

@freezed
class AuthResultMatrix with _$AuthResultMatrix {
  const factory AuthResultMatrix({
    required String host,
    required String credentialId,
    required String protocol,
    required bool? success, // null = pending/unknown, true = success, false = failure
    String? info,
  }) = _AuthResultMatrix;
}
