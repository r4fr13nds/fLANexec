// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smb_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmbAuthResultImpl _$$SmbAuthResultImplFromJson(Map<String, dynamic> json) =>
    _$SmbAuthResultImpl(
      success: json['success'] as bool,
      error: json['error'] as String?,
      osVersion: json['osVersion'] as String?,
      netbiosName: json['netbiosName'] as String?,
      domain: json['domain'] as String?,
      isPdc: json['isPdc'] as bool? ?? false,
      isDomainController: json['isDomainController'] as bool? ?? false,
      signingEnabled: json['signingEnabled'] as bool? ?? false,
      signingRequired: json['signingRequired'] as bool? ?? false,
    );

Map<String, dynamic> _$$SmbAuthResultImplToJson(_$SmbAuthResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'osVersion': instance.osVersion,
      'netbiosName': instance.netbiosName,
      'domain': instance.domain,
      'isPdc': instance.isPdc,
      'isDomainController': instance.isDomainController,
      'signingEnabled': instance.signingEnabled,
      'signingRequired': instance.signingRequired,
    };

_$SmbShareImpl _$$SmbShareImplFromJson(Map<String, dynamic> json) =>
    _$SmbShareImpl(
      name: json['name'] as String,
      type: json['type'] as String,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$SmbShareImplToJson(_$SmbShareImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'remark': instance.remark,
    };

_$SmbDirEntryImpl _$$SmbDirEntryImplFromJson(Map<String, dynamic> json) =>
    _$SmbDirEntryImpl(
      name: json['name'] as String,
      isDirectory: json['isDirectory'] as bool,
      size: (json['size'] as num).toInt(),
      lastModified: DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$$SmbDirEntryImplToJson(_$SmbDirEntryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isDirectory': instance.isDirectory,
      'size': instance.size,
      'lastModified': instance.lastModified.toIso8601String(),
    };

_$SmbAccessResultImpl _$$SmbAccessResultImplFromJson(
  Map<String, dynamic> json,
) => _$SmbAccessResultImpl(
  readable: json['readable'] as bool,
  writable: json['writable'] as bool,
);

Map<String, dynamic> _$$SmbAccessResultImplToJson(
  _$SmbAccessResultImpl instance,
) => <String, dynamic>{
  'readable': instance.readable,
  'writable': instance.writable,
};
