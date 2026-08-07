// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceInfoImpl _$$ServiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$ServiceInfoImpl(
      host: json['host'] as String,
      port: (json['port'] as num).toInt(),
      service: json['service'] as String,
      product: json['product'] as String?,
      version: json['version'] as String?,
      extraInfo: json['extraInfo'] as String?,
      osGuess: json['osGuess'] as String?,
      scripts:
          (json['scripts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      rawOutput: json['rawOutput'] as String,
    );

Map<String, dynamic> _$$ServiceInfoImplToJson(_$ServiceInfoImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'service': instance.service,
      'product': instance.product,
      'version': instance.version,
      'extraInfo': instance.extraInfo,
      'osGuess': instance.osGuess,
      'scripts': instance.scripts,
      'rawOutput': instance.rawOutput,
    };
