// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CredentialSet _$CredentialSetFromJson(Map<String, dynamic> json) {
  return _CredentialSet.fromJson(json);
}

/// @nodoc
mixin _$CredentialSet {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get domain => throw _privateConstructorUsedError;
  String? get hash => throw _privateConstructorUsedError;
  String? get privateKey => throw _privateConstructorUsedError;

  /// Serializes this CredentialSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialSetCopyWith<CredentialSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialSetCopyWith<$Res> {
  factory $CredentialSetCopyWith(
    CredentialSet value,
    $Res Function(CredentialSet) then,
  ) = _$CredentialSetCopyWithImpl<$Res, CredentialSet>;
  @useResult
  $Res call({
    String id,
    String name,
    String username,
    String? password,
    String? domain,
    String? hash,
    String? privateKey,
  });
}

/// @nodoc
class _$CredentialSetCopyWithImpl<$Res, $Val extends CredentialSet>
    implements $CredentialSetCopyWith<$Res> {
  _$CredentialSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? password = freezed,
    Object? domain = freezed,
    Object? hash = freezed,
    Object? privateKey = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
            domain: freezed == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                      as String?,
            hash: freezed == hash
                ? _value.hash
                : hash // ignore: cast_nullable_to_non_nullable
                      as String?,
            privateKey: freezed == privateKey
                ? _value.privateKey
                : privateKey // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CredentialSetImplCopyWith<$Res>
    implements $CredentialSetCopyWith<$Res> {
  factory _$$CredentialSetImplCopyWith(
    _$CredentialSetImpl value,
    $Res Function(_$CredentialSetImpl) then,
  ) = __$$CredentialSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String username,
    String? password,
    String? domain,
    String? hash,
    String? privateKey,
  });
}

/// @nodoc
class __$$CredentialSetImplCopyWithImpl<$Res>
    extends _$CredentialSetCopyWithImpl<$Res, _$CredentialSetImpl>
    implements _$$CredentialSetImplCopyWith<$Res> {
  __$$CredentialSetImplCopyWithImpl(
    _$CredentialSetImpl _value,
    $Res Function(_$CredentialSetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CredentialSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? username = null,
    Object? password = freezed,
    Object? domain = freezed,
    Object? hash = freezed,
    Object? privateKey = freezed,
  }) {
    return _then(
      _$CredentialSetImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
        domain: freezed == domain
            ? _value.domain
            : domain // ignore: cast_nullable_to_non_nullable
                  as String?,
        hash: freezed == hash
            ? _value.hash
            : hash // ignore: cast_nullable_to_non_nullable
                  as String?,
        privateKey: freezed == privateKey
            ? _value.privateKey
            : privateKey // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialSetImpl implements _CredentialSet {
  const _$CredentialSetImpl({
    required this.id,
    required this.name,
    required this.username,
    this.password,
    this.domain,
    this.hash,
    this.privateKey,
  });

  factory _$CredentialSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialSetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String username;
  @override
  final String? password;
  @override
  final String? domain;
  @override
  final String? hash;
  @override
  final String? privateKey;

  @override
  String toString() {
    return 'CredentialSet(id: $id, name: $name, username: $username, password: $password, domain: $domain, hash: $hash, privateKey: $privateKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialSetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.privateKey, privateKey) ||
                other.privateKey == privateKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    username,
    password,
    domain,
    hash,
    privateKey,
  );

  /// Create a copy of CredentialSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialSetImplCopyWith<_$CredentialSetImpl> get copyWith =>
      __$$CredentialSetImplCopyWithImpl<_$CredentialSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialSetImplToJson(this);
  }
}

abstract class _CredentialSet implements CredentialSet {
  const factory _CredentialSet({
    required final String id,
    required final String name,
    required final String username,
    final String? password,
    final String? domain,
    final String? hash,
    final String? privateKey,
  }) = _$CredentialSetImpl;

  factory _CredentialSet.fromJson(Map<String, dynamic> json) =
      _$CredentialSetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get username;
  @override
  String? get password;
  @override
  String? get domain;
  @override
  String? get hash;
  @override
  String? get privateKey;

  /// Create a copy of CredentialSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialSetImplCopyWith<_$CredentialSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthResultMatrix {
  String get host => throw _privateConstructorUsedError;
  String get credentialId => throw _privateConstructorUsedError;
  String get protocol => throw _privateConstructorUsedError;
  bool? get success =>
      throw _privateConstructorUsedError; // null = pending/unknown, true = success, false = failure
  String? get info => throw _privateConstructorUsedError;
  Map<String, dynamic>? get reportData => throw _privateConstructorUsedError;

  /// Create a copy of AuthResultMatrix
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResultMatrixCopyWith<AuthResultMatrix> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResultMatrixCopyWith<$Res> {
  factory $AuthResultMatrixCopyWith(
    AuthResultMatrix value,
    $Res Function(AuthResultMatrix) then,
  ) = _$AuthResultMatrixCopyWithImpl<$Res, AuthResultMatrix>;
  @useResult
  $Res call({
    String host,
    String credentialId,
    String protocol,
    bool? success,
    String? info,
    Map<String, dynamic>? reportData,
  });
}

/// @nodoc
class _$AuthResultMatrixCopyWithImpl<$Res, $Val extends AuthResultMatrix>
    implements $AuthResultMatrixCopyWith<$Res> {
  _$AuthResultMatrixCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResultMatrix
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? credentialId = null,
    Object? protocol = null,
    Object? success = freezed,
    Object? info = freezed,
    Object? reportData = freezed,
  }) {
    return _then(
      _value.copyWith(
            host: null == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                      as String,
            credentialId: null == credentialId
                ? _value.credentialId
                : credentialId // ignore: cast_nullable_to_non_nullable
                      as String,
            protocol: null == protocol
                ? _value.protocol
                : protocol // ignore: cast_nullable_to_non_nullable
                      as String,
            success: freezed == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool?,
            info: freezed == info
                ? _value.info
                : info // ignore: cast_nullable_to_non_nullable
                      as String?,
            reportData: freezed == reportData
                ? _value.reportData
                : reportData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthResultMatrixImplCopyWith<$Res>
    implements $AuthResultMatrixCopyWith<$Res> {
  factory _$$AuthResultMatrixImplCopyWith(
    _$AuthResultMatrixImpl value,
    $Res Function(_$AuthResultMatrixImpl) then,
  ) = __$$AuthResultMatrixImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String host,
    String credentialId,
    String protocol,
    bool? success,
    String? info,
    Map<String, dynamic>? reportData,
  });
}

/// @nodoc
class __$$AuthResultMatrixImplCopyWithImpl<$Res>
    extends _$AuthResultMatrixCopyWithImpl<$Res, _$AuthResultMatrixImpl>
    implements _$$AuthResultMatrixImplCopyWith<$Res> {
  __$$AuthResultMatrixImplCopyWithImpl(
    _$AuthResultMatrixImpl _value,
    $Res Function(_$AuthResultMatrixImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthResultMatrix
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? credentialId = null,
    Object? protocol = null,
    Object? success = freezed,
    Object? info = freezed,
    Object? reportData = freezed,
  }) {
    return _then(
      _$AuthResultMatrixImpl(
        host: null == host
            ? _value.host
            : host // ignore: cast_nullable_to_non_nullable
                  as String,
        credentialId: null == credentialId
            ? _value.credentialId
            : credentialId // ignore: cast_nullable_to_non_nullable
                  as String,
        protocol: null == protocol
            ? _value.protocol
            : protocol // ignore: cast_nullable_to_non_nullable
                  as String,
        success: freezed == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool?,
        info: freezed == info
            ? _value.info
            : info // ignore: cast_nullable_to_non_nullable
                  as String?,
        reportData: freezed == reportData
            ? _value._reportData
            : reportData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$AuthResultMatrixImpl implements _AuthResultMatrix {
  const _$AuthResultMatrixImpl({
    required this.host,
    required this.credentialId,
    required this.protocol,
    required this.success,
    this.info,
    final Map<String, dynamic>? reportData,
  }) : _reportData = reportData;

  @override
  final String host;
  @override
  final String credentialId;
  @override
  final String protocol;
  @override
  final bool? success;
  // null = pending/unknown, true = success, false = failure
  @override
  final String? info;
  final Map<String, dynamic>? _reportData;
  @override
  Map<String, dynamic>? get reportData {
    final value = _reportData;
    if (value == null) return null;
    if (_reportData is EqualUnmodifiableMapView) return _reportData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AuthResultMatrix(host: $host, credentialId: $credentialId, protocol: $protocol, success: $success, info: $info, reportData: $reportData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResultMatrixImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.credentialId, credentialId) ||
                other.credentialId == credentialId) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(
              other._reportData,
              _reportData,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    host,
    credentialId,
    protocol,
    success,
    info,
    const DeepCollectionEquality().hash(_reportData),
  );

  /// Create a copy of AuthResultMatrix
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResultMatrixImplCopyWith<_$AuthResultMatrixImpl> get copyWith =>
      __$$AuthResultMatrixImplCopyWithImpl<_$AuthResultMatrixImpl>(
        this,
        _$identity,
      );
}

abstract class _AuthResultMatrix implements AuthResultMatrix {
  const factory _AuthResultMatrix({
    required final String host,
    required final String credentialId,
    required final String protocol,
    required final bool? success,
    final String? info,
    final Map<String, dynamic>? reportData,
  }) = _$AuthResultMatrixImpl;

  @override
  String get host;
  @override
  String get credentialId;
  @override
  String get protocol;
  @override
  bool? get success; // null = pending/unknown, true = success, false = failure
  @override
  String? get info;
  @override
  Map<String, dynamic>? get reportData;

  /// Create a copy of AuthResultMatrix
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResultMatrixImplCopyWith<_$AuthResultMatrixImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
