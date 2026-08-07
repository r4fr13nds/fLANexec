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

@freezed
class Host with _$Host {
  const Host._();

  const factory Host({
    required String ip,
    String? mac,
    String? hostname,
    required String status,
    double? rttMs,
    @Default([]) List<Port> ports,
    DomainInfo? domainInfo,
    required DateTime lastSeen,
  }) = _Host;

  bool get isDomainController {
    if (domainInfo != null) return true;
    final ldapPorts = [389, 636, 3268, 3269];
    return ports.any((p) => ldapPorts.contains(p.port) && p.state == 'open');
  }

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
}
