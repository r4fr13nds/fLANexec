// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShareAccessReportImpl _$$ShareAccessReportImplFromJson(
  Map<String, dynamic> json,
) => _$ShareAccessReportImpl(
  shareName: json['shareName'] as String,
  accessLevel: json['accessLevel'] as String,
  itemCount: (json['itemCount'] as num).toInt(),
  sampleFiles:
      (json['sampleFiles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ShareAccessReportImplToJson(
  _$ShareAccessReportImpl instance,
) => <String, dynamic>{
  'shareName': instance.shareName,
  'accessLevel': instance.accessLevel,
  'itemCount': instance.itemCount,
  'sampleFiles': instance.sampleFiles,
};

_$WinrmPermissionReportImpl _$$WinrmPermissionReportImplFromJson(
  Map<String, dynamic> json,
) => _$WinrmPermissionReportImpl(
  username: json['username'] as String,
  sid: json['sid'] as String,
  groups:
      (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  privileges:
      (json['privileges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$WinrmPermissionReportImplToJson(
  _$WinrmPermissionReportImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'sid': instance.sid,
  'groups': instance.groups,
  'privileges': instance.privileges,
};

_$LdapGroupInfoImpl _$$LdapGroupInfoImplFromJson(Map<String, dynamic> json) =>
    _$LdapGroupInfoImpl(
      name: json['name'] as String,
      dn: json['dn'] as String,
      description: json['description'] as String?,
      memberCount: (json['memberCount'] as num).toInt(),
      isHighPrivilege: json['isHighPrivilege'] as bool? ?? false,
    );

Map<String, dynamic> _$$LdapGroupInfoImplToJson(_$LdapGroupInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dn': instance.dn,
      'description': instance.description,
      'memberCount': instance.memberCount,
      'isHighPrivilege': instance.isHighPrivilege,
    };

_$SshPermissionReportImpl _$$SshPermissionReportImplFromJson(
  Map<String, dynamic> json,
) => _$SshPermissionReportImpl(
  uid: json['uid'] as String,
  gid: json['gid'] as String,
  groups:
      (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  sudoCommands:
      (json['sudoCommands'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$SshPermissionReportImplToJson(
  _$SshPermissionReportImpl instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'gid': instance.gid,
  'groups': instance.groups,
  'sudoCommands': instance.sudoCommands,
};
