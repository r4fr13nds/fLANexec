// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Port _$PortFromJson(Map<String, dynamic> json) {
  return _Port.fromJson(json);
}

/// @nodoc
mixin _$Port {
  int get port => throw _privateConstructorUsedError;
  String get protocol => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;
  String? get banner => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;

  /// Serializes this Port to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Port
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortCopyWith<Port> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortCopyWith<$Res> {
  factory $PortCopyWith(Port value, $Res Function(Port) then) =
      _$PortCopyWithImpl<$Res, Port>;
  @useResult
  $Res call({
    int port,
    String protocol,
    String state,
    String? service,
    String? banner,
    String? version,
  });
}

/// @nodoc
class _$PortCopyWithImpl<$Res, $Val extends Port>
    implements $PortCopyWith<$Res> {
  _$PortCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Port
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
    Object? protocol = null,
    Object? state = null,
    Object? service = freezed,
    Object? banner = freezed,
    Object? version = freezed,
  }) {
    return _then(
      _value.copyWith(
            port: null == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int,
            protocol: null == protocol
                ? _value.protocol
                : protocol // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            service: freezed == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as String?,
            banner: freezed == banner
                ? _value.banner
                : banner // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PortImplCopyWith<$Res> implements $PortCopyWith<$Res> {
  factory _$$PortImplCopyWith(
    _$PortImpl value,
    $Res Function(_$PortImpl) then,
  ) = __$$PortImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int port,
    String protocol,
    String state,
    String? service,
    String? banner,
    String? version,
  });
}

/// @nodoc
class __$$PortImplCopyWithImpl<$Res>
    extends _$PortCopyWithImpl<$Res, _$PortImpl>
    implements _$$PortImplCopyWith<$Res> {
  __$$PortImplCopyWithImpl(_$PortImpl _value, $Res Function(_$PortImpl) _then)
    : super(_value, _then);

  /// Create a copy of Port
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
    Object? protocol = null,
    Object? state = null,
    Object? service = freezed,
    Object? banner = freezed,
    Object? version = freezed,
  }) {
    return _then(
      _$PortImpl(
        port: null == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
        protocol: null == protocol
            ? _value.protocol
            : protocol // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        service: freezed == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as String?,
        banner: freezed == banner
            ? _value.banner
            : banner // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PortImpl implements _Port {
  const _$PortImpl({
    required this.port,
    required this.protocol,
    required this.state,
    this.service,
    this.banner,
    this.version,
  });

  factory _$PortImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortImplFromJson(json);

  @override
  final int port;
  @override
  final String protocol;
  @override
  final String state;
  @override
  final String? service;
  @override
  final String? banner;
  @override
  final String? version;

  @override
  String toString() {
    return 'Port(port: $port, protocol: $protocol, state: $state, service: $service, banner: $banner, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortImpl &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, port, protocol, state, service, banner, version);

  /// Create a copy of Port
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortImplCopyWith<_$PortImpl> get copyWith =>
      __$$PortImplCopyWithImpl<_$PortImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortImplToJson(this);
  }
}

abstract class _Port implements Port {
  const factory _Port({
    required final int port,
    required final String protocol,
    required final String state,
    final String? service,
    final String? banner,
    final String? version,
  }) = _$PortImpl;

  factory _Port.fromJson(Map<String, dynamic> json) = _$PortImpl.fromJson;

  @override
  int get port;
  @override
  String get protocol;
  @override
  String get state;
  @override
  String? get service;
  @override
  String? get banner;
  @override
  String? get version;

  /// Create a copy of Port
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortImplCopyWith<_$PortImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Host _$HostFromJson(Map<String, dynamic> json) {
  return _Host.fromJson(json);
}

/// @nodoc
mixin _$Host {
  String get ip => throw _privateConstructorUsedError;
  String? get mac => throw _privateConstructorUsedError;
  String? get hostname => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get rttMs => throw _privateConstructorUsedError;
  List<Port> get ports => throw _privateConstructorUsedError;
  DomainInfo? get domainInfo => throw _privateConstructorUsedError;
  DateTime get lastSeen => throw _privateConstructorUsedError;

  /// Serializes this Host to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HostCopyWith<Host> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostCopyWith<$Res> {
  factory $HostCopyWith(Host value, $Res Function(Host) then) =
      _$HostCopyWithImpl<$Res, Host>;
  @useResult
  $Res call({
    String ip,
    String? mac,
    String? hostname,
    String status,
    double? rttMs,
    List<Port> ports,
    DomainInfo? domainInfo,
    DateTime lastSeen,
  });

  $DomainInfoCopyWith<$Res>? get domainInfo;
}

/// @nodoc
class _$HostCopyWithImpl<$Res, $Val extends Host>
    implements $HostCopyWith<$Res> {
  _$HostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? mac = freezed,
    Object? hostname = freezed,
    Object? status = null,
    Object? rttMs = freezed,
    Object? ports = null,
    Object? domainInfo = freezed,
    Object? lastSeen = null,
  }) {
    return _then(
      _value.copyWith(
            ip: null == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String,
            mac: freezed == mac
                ? _value.mac
                : mac // ignore: cast_nullable_to_non_nullable
                      as String?,
            hostname: freezed == hostname
                ? _value.hostname
                : hostname // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            rttMs: freezed == rttMs
                ? _value.rttMs
                : rttMs // ignore: cast_nullable_to_non_nullable
                      as double?,
            ports: null == ports
                ? _value.ports
                : ports // ignore: cast_nullable_to_non_nullable
                      as List<Port>,
            domainInfo: freezed == domainInfo
                ? _value.domainInfo
                : domainInfo // ignore: cast_nullable_to_non_nullable
                      as DomainInfo?,
            lastSeen: null == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DomainInfoCopyWith<$Res>? get domainInfo {
    if (_value.domainInfo == null) {
      return null;
    }

    return $DomainInfoCopyWith<$Res>(_value.domainInfo!, (value) {
      return _then(_value.copyWith(domainInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HostImplCopyWith<$Res> implements $HostCopyWith<$Res> {
  factory _$$HostImplCopyWith(
    _$HostImpl value,
    $Res Function(_$HostImpl) then,
  ) = __$$HostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ip,
    String? mac,
    String? hostname,
    String status,
    double? rttMs,
    List<Port> ports,
    DomainInfo? domainInfo,
    DateTime lastSeen,
  });

  @override
  $DomainInfoCopyWith<$Res>? get domainInfo;
}

/// @nodoc
class __$$HostImplCopyWithImpl<$Res>
    extends _$HostCopyWithImpl<$Res, _$HostImpl>
    implements _$$HostImplCopyWith<$Res> {
  __$$HostImplCopyWithImpl(_$HostImpl _value, $Res Function(_$HostImpl) _then)
    : super(_value, _then);

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? mac = freezed,
    Object? hostname = freezed,
    Object? status = null,
    Object? rttMs = freezed,
    Object? ports = null,
    Object? domainInfo = freezed,
    Object? lastSeen = null,
  }) {
    return _then(
      _$HostImpl(
        ip: null == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String,
        mac: freezed == mac
            ? _value.mac
            : mac // ignore: cast_nullable_to_non_nullable
                  as String?,
        hostname: freezed == hostname
            ? _value.hostname
            : hostname // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        rttMs: freezed == rttMs
            ? _value.rttMs
            : rttMs // ignore: cast_nullable_to_non_nullable
                  as double?,
        ports: null == ports
            ? _value._ports
            : ports // ignore: cast_nullable_to_non_nullable
                  as List<Port>,
        domainInfo: freezed == domainInfo
            ? _value.domainInfo
            : domainInfo // ignore: cast_nullable_to_non_nullable
                  as DomainInfo?,
        lastSeen: null == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HostImpl extends _Host {
  const _$HostImpl({
    required this.ip,
    this.mac,
    this.hostname,
    required this.status,
    this.rttMs,
    final List<Port> ports = const [],
    this.domainInfo,
    required this.lastSeen,
  }) : _ports = ports,
       super._();

  factory _$HostImpl.fromJson(Map<String, dynamic> json) =>
      _$$HostImplFromJson(json);

  @override
  final String ip;
  @override
  final String? mac;
  @override
  final String? hostname;
  @override
  final String status;
  @override
  final double? rttMs;
  final List<Port> _ports;
  @override
  @JsonKey()
  List<Port> get ports {
    if (_ports is EqualUnmodifiableListView) return _ports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ports);
  }

  @override
  final DomainInfo? domainInfo;
  @override
  final DateTime lastSeen;

  @override
  String toString() {
    return 'Host(ip: $ip, mac: $mac, hostname: $hostname, status: $status, rttMs: $rttMs, ports: $ports, domainInfo: $domainInfo, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.mac, mac) || other.mac == mac) &&
            (identical(other.hostname, hostname) ||
                other.hostname == hostname) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rttMs, rttMs) || other.rttMs == rttMs) &&
            const DeepCollectionEquality().equals(other._ports, _ports) &&
            (identical(other.domainInfo, domainInfo) ||
                other.domainInfo == domainInfo) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ip,
    mac,
    hostname,
    status,
    rttMs,
    const DeepCollectionEquality().hash(_ports),
    domainInfo,
    lastSeen,
  );

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HostImplCopyWith<_$HostImpl> get copyWith =>
      __$$HostImplCopyWithImpl<_$HostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HostImplToJson(this);
  }
}

abstract class _Host extends Host {
  const factory _Host({
    required final String ip,
    final String? mac,
    final String? hostname,
    required final String status,
    final double? rttMs,
    final List<Port> ports,
    final DomainInfo? domainInfo,
    required final DateTime lastSeen,
  }) = _$HostImpl;
  const _Host._() : super._();

  factory _Host.fromJson(Map<String, dynamic> json) = _$HostImpl.fromJson;

  @override
  String get ip;
  @override
  String? get mac;
  @override
  String? get hostname;
  @override
  String get status;
  @override
  double? get rttMs;
  @override
  List<Port> get ports;
  @override
  DomainInfo? get domainInfo;
  @override
  DateTime get lastSeen;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HostImplCopyWith<_$HostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
