// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialSetImpl _$$CredentialSetImplFromJson(Map<String, dynamic> json) =>
    _$CredentialSetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      domain: json['domain'] as String?,
      hash: json['hash'] as String?,
      privateKey: json['privateKey'] as String?,
    );

Map<String, dynamic> _$$CredentialSetImplToJson(_$CredentialSetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'domain': instance.domain,
      'hash': instance.hash,
      'privateKey': instance.privateKey,
    };
