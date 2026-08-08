// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortImpl _$$PortImplFromJson(Map<String, dynamic> json) => _$PortImpl(
  port: (json['port'] as num).toInt(),
  protocol: json['protocol'] as String,
  state: json['state'] as String,
  service: json['service'] as String?,
  banner: json['banner'] as String?,
  version: json['version'] as String?,
);

Map<String, dynamic> _$$PortImplToJson(_$PortImpl instance) =>
    <String, dynamic>{
      'port': instance.port,
      'protocol': instance.protocol,
      'state': instance.state,
      'service': instance.service,
      'banner': instance.banner,
      'version': instance.version,
    };

_$HostImpl _$$HostImplFromJson(Map<String, dynamic> json) => _$HostImpl(
  ip: json['ip'] as String,
  macAddress: json['macAddress'] as String?,
  hostname: json['hostname'] as String?,
  netbiosName: json['netbiosName'] as String?,
  domain: json['domain'] as String?,
  isDomainController: json['isDomainController'] as bool? ?? false,
  osType:
      $enumDecodeNullable(_$HostOsEnumMap, json['osType']) ?? HostOs.unknown,
  osVersion: json['osVersion'] as String?,
  ttl: (json['ttl'] as num?)?.toInt(),
  status: json['status'] as String,
  rttMs: (json['rttMs'] as num?)?.toDouble(),
  ports:
      (json['ports'] as List<dynamic>?)
          ?.map((e) => Port.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  domainInfo: json['domainInfo'] == null
      ? null
      : DomainInfo.fromJson(json['domainInfo'] as Map<String, dynamic>),
  lastSeen: DateTime.parse(json['lastSeen'] as String),
);

Map<String, dynamic> _$$HostImplToJson(_$HostImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'macAddress': instance.macAddress,
      'hostname': instance.hostname,
      'netbiosName': instance.netbiosName,
      'domain': instance.domain,
      'isDomainController': instance.isDomainController,
      'osType': _$HostOsEnumMap[instance.osType]!,
      'osVersion': instance.osVersion,
      'ttl': instance.ttl,
      'status': instance.status,
      'rttMs': instance.rttMs,
      'ports': instance.ports,
      'domainInfo': instance.domainInfo,
      'lastSeen': instance.lastSeen.toIso8601String(),
    };

const _$HostOsEnumMap = {
  HostOs.windows: 'windows',
  HostOs.linux: 'linux',
  HostOs.macos: 'macos',
  HostOs.ios: 'ios',
  HostOs.android: 'android',
  HostOs.networkDevice: 'networkDevice',
  HostOs.unknown: 'unknown',
};
