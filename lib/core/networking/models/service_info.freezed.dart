// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ServiceInfo _$ServiceInfoFromJson(Map<String, dynamic> json) {
  return _ServiceInfo.fromJson(json);
}

/// @nodoc
mixin _$ServiceInfo {
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  String? get product => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get extraInfo => throw _privateConstructorUsedError;
  String? get osGuess => throw _privateConstructorUsedError;
  Map<String, String> get scripts => throw _privateConstructorUsedError;
  String get rawOutput => throw _privateConstructorUsedError;

  /// Serializes this ServiceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceInfoCopyWith<ServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceInfoCopyWith<$Res> {
  factory $ServiceInfoCopyWith(
    ServiceInfo value,
    $Res Function(ServiceInfo) then,
  ) = _$ServiceInfoCopyWithImpl<$Res, ServiceInfo>;
  @useResult
  $Res call({
    String host,
    int port,
    String service,
    String? product,
    String? version,
    String? extraInfo,
    String? osGuess,
    Map<String, String> scripts,
    String rawOutput,
  });
}

/// @nodoc
class _$ServiceInfoCopyWithImpl<$Res, $Val extends ServiceInfo>
    implements $ServiceInfoCopyWith<$Res> {
  _$ServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? service = null,
    Object? product = freezed,
    Object? version = freezed,
    Object? extraInfo = freezed,
    Object? osGuess = freezed,
    Object? scripts = null,
    Object? rawOutput = null,
  }) {
    return _then(
      _value.copyWith(
            host: null == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                      as String,
            port: null == port
                ? _value.port
                : port // ignore: cast_nullable_to_non_nullable
                      as int,
            service: null == service
                ? _value.service
                : service // ignore: cast_nullable_to_non_nullable
                      as String,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String?,
            extraInfo: freezed == extraInfo
                ? _value.extraInfo
                : extraInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            osGuess: freezed == osGuess
                ? _value.osGuess
                : osGuess // ignore: cast_nullable_to_non_nullable
                      as String?,
            scripts: null == scripts
                ? _value.scripts
                : scripts // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            rawOutput: null == rawOutput
                ? _value.rawOutput
                : rawOutput // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServiceInfoImplCopyWith<$Res>
    implements $ServiceInfoCopyWith<$Res> {
  factory _$$ServiceInfoImplCopyWith(
    _$ServiceInfoImpl value,
    $Res Function(_$ServiceInfoImpl) then,
  ) = __$$ServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String host,
    int port,
    String service,
    String? product,
    String? version,
    String? extraInfo,
    String? osGuess,
    Map<String, String> scripts,
    String rawOutput,
  });
}

/// @nodoc
class __$$ServiceInfoImplCopyWithImpl<$Res>
    extends _$ServiceInfoCopyWithImpl<$Res, _$ServiceInfoImpl>
    implements _$$ServiceInfoImplCopyWith<$Res> {
  __$$ServiceInfoImplCopyWithImpl(
    _$ServiceInfoImpl _value,
    $Res Function(_$ServiceInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? service = null,
    Object? product = freezed,
    Object? version = freezed,
    Object? extraInfo = freezed,
    Object? osGuess = freezed,
    Object? scripts = null,
    Object? rawOutput = null,
  }) {
    return _then(
      _$ServiceInfoImpl(
        host: null == host
            ? _value.host
            : host // ignore: cast_nullable_to_non_nullable
                  as String,
        port: null == port
            ? _value.port
            : port // ignore: cast_nullable_to_non_nullable
                  as int,
        service: null == service
            ? _value.service
            : service // ignore: cast_nullable_to_non_nullable
                  as String,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
        extraInfo: freezed == extraInfo
            ? _value.extraInfo
            : extraInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        osGuess: freezed == osGuess
            ? _value.osGuess
            : osGuess // ignore: cast_nullable_to_non_nullable
                  as String?,
        scripts: null == scripts
            ? _value._scripts
            : scripts // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        rawOutput: null == rawOutput
            ? _value.rawOutput
            : rawOutput // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceInfoImpl implements _ServiceInfo {
  const _$ServiceInfoImpl({
    required this.host,
    required this.port,
    required this.service,
    this.product,
    this.version,
    this.extraInfo,
    this.osGuess,
    final Map<String, String> scripts = const {},
    required this.rawOutput,
  }) : _scripts = scripts;

  factory _$ServiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceInfoImplFromJson(json);

  @override
  final String host;
  @override
  final int port;
  @override
  final String service;
  @override
  final String? product;
  @override
  final String? version;
  @override
  final String? extraInfo;
  @override
  final String? osGuess;
  final Map<String, String> _scripts;
  @override
  @JsonKey()
  Map<String, String> get scripts {
    if (_scripts is EqualUnmodifiableMapView) return _scripts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_scripts);
  }

  @override
  final String rawOutput;

  @override
  String toString() {
    return 'ServiceInfo(host: $host, port: $port, service: $service, product: $product, version: $version, extraInfo: $extraInfo, osGuess: $osGuess, scripts: $scripts, rawOutput: $rawOutput)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceInfoImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.extraInfo, extraInfo) ||
                other.extraInfo == extraInfo) &&
            (identical(other.osGuess, osGuess) || other.osGuess == osGuess) &&
            const DeepCollectionEquality().equals(other._scripts, _scripts) &&
            (identical(other.rawOutput, rawOutput) ||
                other.rawOutput == rawOutput));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    host,
    port,
    service,
    product,
    version,
    extraInfo,
    osGuess,
    const DeepCollectionEquality().hash(_scripts),
    rawOutput,
  );

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      __$$ServiceInfoImplCopyWithImpl<_$ServiceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceInfoImplToJson(this);
  }
}

abstract class _ServiceInfo implements ServiceInfo {
  const factory _ServiceInfo({
    required final String host,
    required final int port,
    required final String service,
    final String? product,
    final String? version,
    final String? extraInfo,
    final String? osGuess,
    final Map<String, String> scripts,
    required final String rawOutput,
  }) = _$ServiceInfoImpl;

  factory _ServiceInfo.fromJson(Map<String, dynamic> json) =
      _$ServiceInfoImpl.fromJson;

  @override
  String get host;
  @override
  int get port;
  @override
  String get service;
  @override
  String? get product;
  @override
  String? get version;
  @override
  String? get extraInfo;
  @override
  String? get osGuess;
  @override
  Map<String, String> get scripts;
  @override
  String get rawOutput;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
