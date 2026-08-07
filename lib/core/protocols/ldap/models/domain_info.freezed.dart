// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DomainInfo _$DomainInfoFromJson(Map<String, dynamic> json) {
  return _DomainInfo.fromJson(json);
}

/// @nodoc
mixin _$DomainInfo {
  String? get domain => throw _privateConstructorUsedError;
  String? get forest => throw _privateConstructorUsedError;
  String? get dnsHostName => throw _privateConstructorUsedError;
  String? get serverDn => throw _privateConstructorUsedError;
  bool get isGlobalCatalog => throw _privateConstructorUsedError;
  int? get functionalLevel => throw _privateConstructorUsedError;
  List<String> get supportedMechs => throw _privateConstructorUsedError;

  /// Serializes this DomainInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DomainInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DomainInfoCopyWith<DomainInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DomainInfoCopyWith<$Res> {
  factory $DomainInfoCopyWith(
    DomainInfo value,
    $Res Function(DomainInfo) then,
  ) = _$DomainInfoCopyWithImpl<$Res, DomainInfo>;
  @useResult
  $Res call({
    String? domain,
    String? forest,
    String? dnsHostName,
    String? serverDn,
    bool isGlobalCatalog,
    int? functionalLevel,
    List<String> supportedMechs,
  });
}

/// @nodoc
class _$DomainInfoCopyWithImpl<$Res, $Val extends DomainInfo>
    implements $DomainInfoCopyWith<$Res> {
  _$DomainInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DomainInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = freezed,
    Object? forest = freezed,
    Object? dnsHostName = freezed,
    Object? serverDn = freezed,
    Object? isGlobalCatalog = null,
    Object? functionalLevel = freezed,
    Object? supportedMechs = null,
  }) {
    return _then(
      _value.copyWith(
            domain: freezed == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                      as String?,
            forest: freezed == forest
                ? _value.forest
                : forest // ignore: cast_nullable_to_non_nullable
                      as String?,
            dnsHostName: freezed == dnsHostName
                ? _value.dnsHostName
                : dnsHostName // ignore: cast_nullable_to_non_nullable
                      as String?,
            serverDn: freezed == serverDn
                ? _value.serverDn
                : serverDn // ignore: cast_nullable_to_non_nullable
                      as String?,
            isGlobalCatalog: null == isGlobalCatalog
                ? _value.isGlobalCatalog
                : isGlobalCatalog // ignore: cast_nullable_to_non_nullable
                      as bool,
            functionalLevel: freezed == functionalLevel
                ? _value.functionalLevel
                : functionalLevel // ignore: cast_nullable_to_non_nullable
                      as int?,
            supportedMechs: null == supportedMechs
                ? _value.supportedMechs
                : supportedMechs // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DomainInfoImplCopyWith<$Res>
    implements $DomainInfoCopyWith<$Res> {
  factory _$$DomainInfoImplCopyWith(
    _$DomainInfoImpl value,
    $Res Function(_$DomainInfoImpl) then,
  ) = __$$DomainInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? domain,
    String? forest,
    String? dnsHostName,
    String? serverDn,
    bool isGlobalCatalog,
    int? functionalLevel,
    List<String> supportedMechs,
  });
}

/// @nodoc
class __$$DomainInfoImplCopyWithImpl<$Res>
    extends _$DomainInfoCopyWithImpl<$Res, _$DomainInfoImpl>
    implements _$$DomainInfoImplCopyWith<$Res> {
  __$$DomainInfoImplCopyWithImpl(
    _$DomainInfoImpl _value,
    $Res Function(_$DomainInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DomainInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = freezed,
    Object? forest = freezed,
    Object? dnsHostName = freezed,
    Object? serverDn = freezed,
    Object? isGlobalCatalog = null,
    Object? functionalLevel = freezed,
    Object? supportedMechs = null,
  }) {
    return _then(
      _$DomainInfoImpl(
        domain: freezed == domain
            ? _value.domain
            : domain // ignore: cast_nullable_to_non_nullable
                  as String?,
        forest: freezed == forest
            ? _value.forest
            : forest // ignore: cast_nullable_to_non_nullable
                  as String?,
        dnsHostName: freezed == dnsHostName
            ? _value.dnsHostName
            : dnsHostName // ignore: cast_nullable_to_non_nullable
                  as String?,
        serverDn: freezed == serverDn
            ? _value.serverDn
            : serverDn // ignore: cast_nullable_to_non_nullable
                  as String?,
        isGlobalCatalog: null == isGlobalCatalog
            ? _value.isGlobalCatalog
            : isGlobalCatalog // ignore: cast_nullable_to_non_nullable
                  as bool,
        functionalLevel: freezed == functionalLevel
            ? _value.functionalLevel
            : functionalLevel // ignore: cast_nullable_to_non_nullable
                  as int?,
        supportedMechs: null == supportedMechs
            ? _value._supportedMechs
            : supportedMechs // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DomainInfoImpl implements _DomainInfo {
  const _$DomainInfoImpl({
    this.domain,
    this.forest,
    this.dnsHostName,
    this.serverDn,
    this.isGlobalCatalog = false,
    this.functionalLevel,
    final List<String> supportedMechs = const [],
  }) : _supportedMechs = supportedMechs;

  factory _$DomainInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DomainInfoImplFromJson(json);

  @override
  final String? domain;
  @override
  final String? forest;
  @override
  final String? dnsHostName;
  @override
  final String? serverDn;
  @override
  @JsonKey()
  final bool isGlobalCatalog;
  @override
  final int? functionalLevel;
  final List<String> _supportedMechs;
  @override
  @JsonKey()
  List<String> get supportedMechs {
    if (_supportedMechs is EqualUnmodifiableListView) return _supportedMechs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedMechs);
  }

  @override
  String toString() {
    return 'DomainInfo(domain: $domain, forest: $forest, dnsHostName: $dnsHostName, serverDn: $serverDn, isGlobalCatalog: $isGlobalCatalog, functionalLevel: $functionalLevel, supportedMechs: $supportedMechs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DomainInfoImpl &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.forest, forest) || other.forest == forest) &&
            (identical(other.dnsHostName, dnsHostName) ||
                other.dnsHostName == dnsHostName) &&
            (identical(other.serverDn, serverDn) ||
                other.serverDn == serverDn) &&
            (identical(other.isGlobalCatalog, isGlobalCatalog) ||
                other.isGlobalCatalog == isGlobalCatalog) &&
            (identical(other.functionalLevel, functionalLevel) ||
                other.functionalLevel == functionalLevel) &&
            const DeepCollectionEquality().equals(
              other._supportedMechs,
              _supportedMechs,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    domain,
    forest,
    dnsHostName,
    serverDn,
    isGlobalCatalog,
    functionalLevel,
    const DeepCollectionEquality().hash(_supportedMechs),
  );

  /// Create a copy of DomainInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DomainInfoImplCopyWith<_$DomainInfoImpl> get copyWith =>
      __$$DomainInfoImplCopyWithImpl<_$DomainInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DomainInfoImplToJson(this);
  }
}

abstract class _DomainInfo implements DomainInfo {
  const factory _DomainInfo({
    final String? domain,
    final String? forest,
    final String? dnsHostName,
    final String? serverDn,
    final bool isGlobalCatalog,
    final int? functionalLevel,
    final List<String> supportedMechs,
  }) = _$DomainInfoImpl;

  factory _DomainInfo.fromJson(Map<String, dynamic> json) =
      _$DomainInfoImpl.fromJson;

  @override
  String? get domain;
  @override
  String? get forest;
  @override
  String? get dnsHostName;
  @override
  String? get serverDn;
  @override
  bool get isGlobalCatalog;
  @override
  int? get functionalLevel;
  @override
  List<String> get supportedMechs;

  /// Create a copy of DomainInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DomainInfoImplCopyWith<_$DomainInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
