import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports.freezed.dart';
part 'reports.g.dart';

@freezed
class ShareAccessReport with _$ShareAccessReport {
  const factory ShareAccessReport({
    required String shareName,
    required String accessLevel, // READ, WRITE, DENIED
    required int itemCount,
    @Default([]) List<String> sampleFiles,
  }) = _ShareAccessReport;

  factory ShareAccessReport.fromJson(Map<String, dynamic> json) => _$ShareAccessReportFromJson(json);
}

@freezed
class WinrmPermissionReport with _$WinrmPermissionReport {
  const factory WinrmPermissionReport({
    required String username,
    required String sid,
    @Default([]) List<String> groups,
    @Default([]) List<String> privileges,
  }) = _WinrmPermissionReport;

  factory WinrmPermissionReport.fromJson(Map<String, dynamic> json) => _$WinrmPermissionReportFromJson(json);
}

@freezed
class LdapGroupInfo with _$LdapGroupInfo {
  const factory LdapGroupInfo({
    required String name,
    required String dn,
    String? description,
    required int memberCount,
    @Default(false) bool isHighPrivilege,
  }) = _LdapGroupInfo;

  factory LdapGroupInfo.fromJson(Map<String, dynamic> json) => _$LdapGroupInfoFromJson(json);
}

@freezed
class SshPermissionReport with _$SshPermissionReport {
  const factory SshPermissionReport({
    required String uid,
    required String gid,
    @Default([]) List<String> groups,
    @Default([]) List<String> sudoCommands,
  }) = _SshPermissionReport;

  factory SshPermissionReport.fromJson(Map<String, dynamic> json) => _$SshPermissionReportFromJson(json);
}
