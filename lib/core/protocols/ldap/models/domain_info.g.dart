// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DomainInfoImpl _$$DomainInfoImplFromJson(Map<String, dynamic> json) =>
    _$DomainInfoImpl(
      domain: json['domain'] as String?,
      forest: json['forest'] as String?,
      dnsHostName: json['dnsHostName'] as String?,
      serverDn: json['serverDn'] as String?,
      isGlobalCatalog: json['isGlobalCatalog'] as bool? ?? false,
      functionalLevel: (json['functionalLevel'] as num?)?.toInt(),
      supportedMechs:
          (json['supportedMechs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DomainInfoImplToJson(_$DomainInfoImpl instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'forest': instance.forest,
      'dnsHostName': instance.dnsHostName,
      'serverDn': instance.serverDn,
      'isGlobalCatalog': instance.isGlobalCatalog,
      'functionalLevel': instance.functionalLevel,
      'supportedMechs': instance.supportedMechs,
    };
