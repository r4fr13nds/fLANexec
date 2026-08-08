import 'package:flanexec/core/protocols/ldap/models/domain_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host.freezed.dart';
part 'host.g.dart';

@freezed
class Port with _$Port {
  const factory Port({
    required int port,
    required String protocol,
    required String state,
    String? service,
    String? banner,
    String? version,
  }) = _Port;

  factory Port.fromJson(Map<String, dynamic> json) => _$PortFromJson(json);
}

enum HostOs { windows, linux, macos, ios, android, networkDevice, unknown }

@freezed
class Host with _$Host {
  const Host._();

  const factory Host({
    required String ip,
    String? macAddress,
    String? hostname,
    String? netbiosName,
    String? domain,
    @Default(false) bool isDomainController,
    @Default(HostOs.unknown) HostOs osType,
    String? osVersion,
    int? ttl,
    required String status,
    double? rttMs,
    @Default([]) List<Port> ports,
    DomainInfo? domainInfo,
    required DateTime lastSeen,
  }) = _Host;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
}
