// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smb_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SmbAuthResult _$SmbAuthResultFromJson(Map<String, dynamic> json) {
  return _SmbAuthResult.fromJson(json);
}

/// @nodoc
mixin _$SmbAuthResult {
  bool get success => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get osVersion => throw _privateConstructorUsedError;
  String? get netbiosName => throw _privateConstructorUsedError;
  String? get domain => throw _privateConstructorUsedError;
  bool get isPdc => throw _privateConstructorUsedError;
  bool get isDomainController => throw _privateConstructorUsedError;
  bool get signingEnabled => throw _privateConstructorUsedError;
  bool get signingRequired => throw _privateConstructorUsedError;

  /// Serializes this SmbAuthResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmbAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmbAuthResultCopyWith<SmbAuthResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmbAuthResultCopyWith<$Res> {
  factory $SmbAuthResultCopyWith(
    SmbAuthResult value,
    $Res Function(SmbAuthResult) then,
  ) = _$SmbAuthResultCopyWithImpl<$Res, SmbAuthResult>;
  @useResult
  $Res call({
    bool success,
    String? error,
    String? osVersion,
    String? netbiosName,
    String? domain,
    bool isPdc,
    bool isDomainController,
    bool signingEnabled,
    bool signingRequired,
  });
}

/// @nodoc
class _$SmbAuthResultCopyWithImpl<$Res, $Val extends SmbAuthResult>
    implements $SmbAuthResultCopyWith<$Res> {
  _$SmbAuthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmbAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? osVersion = freezed,
    Object? netbiosName = freezed,
    Object? domain = freezed,
    Object? isPdc = null,
    Object? isDomainController = null,
    Object? signingEnabled = null,
    Object? signingRequired = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            osVersion: freezed == osVersion
                ? _value.osVersion
                : osVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            netbiosName: freezed == netbiosName
                ? _value.netbiosName
                : netbiosName // ignore: cast_nullable_to_non_nullable
                      as String?,
            domain: freezed == domain
                ? _value.domain
                : domain // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPdc: null == isPdc
                ? _value.isPdc
                : isPdc // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDomainController: null == isDomainController
                ? _value.isDomainController
                : isDomainController // ignore: cast_nullable_to_non_nullable
                      as bool,
            signingEnabled: null == signingEnabled
                ? _value.signingEnabled
                : signingEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            signingRequired: null == signingRequired
                ? _value.signingRequired
                : signingRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmbAuthResultImplCopyWith<$Res>
    implements $SmbAuthResultCopyWith<$Res> {
  factory _$$SmbAuthResultImplCopyWith(
    _$SmbAuthResultImpl value,
    $Res Function(_$SmbAuthResultImpl) then,
  ) = __$$SmbAuthResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String? error,
    String? osVersion,
    String? netbiosName,
    String? domain,
    bool isPdc,
    bool isDomainController,
    bool signingEnabled,
    bool signingRequired,
  });
}

/// @nodoc
class __$$SmbAuthResultImplCopyWithImpl<$Res>
    extends _$SmbAuthResultCopyWithImpl<$Res, _$SmbAuthResultImpl>
    implements _$$SmbAuthResultImplCopyWith<$Res> {
  __$$SmbAuthResultImplCopyWithImpl(
    _$SmbAuthResultImpl _value,
    $Res Function(_$SmbAuthResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmbAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? error = freezed,
    Object? osVersion = freezed,
    Object? netbiosName = freezed,
    Object? domain = freezed,
    Object? isPdc = null,
    Object? isDomainController = null,
    Object? signingEnabled = null,
    Object? signingRequired = null,
  }) {
    return _then(
      _$SmbAuthResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        osVersion: freezed == osVersion
            ? _value.osVersion
            : osVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        netbiosName: freezed == netbiosName
            ? _value.netbiosName
            : netbiosName // ignore: cast_nullable_to_non_nullable
                  as String?,
        domain: freezed == domain
            ? _value.domain
            : domain // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPdc: null == isPdc
            ? _value.isPdc
            : isPdc // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDomainController: null == isDomainController
            ? _value.isDomainController
            : isDomainController // ignore: cast_nullable_to_non_nullable
                  as bool,
        signingEnabled: null == signingEnabled
            ? _value.signingEnabled
            : signingEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        signingRequired: null == signingRequired
            ? _value.signingRequired
            : signingRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmbAuthResultImpl implements _SmbAuthResult {
  const _$SmbAuthResultImpl({
    required this.success,
    this.error,
    this.osVersion,
    this.netbiosName,
    this.domain,
    this.isPdc = false,
    this.isDomainController = false,
    this.signingEnabled = false,
    this.signingRequired = false,
  });

  factory _$SmbAuthResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmbAuthResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String? error;
  @override
  final String? osVersion;
  @override
  final String? netbiosName;
  @override
  final String? domain;
  @override
  @JsonKey()
  final bool isPdc;
  @override
  @JsonKey()
  final bool isDomainController;
  @override
  @JsonKey()
  final bool signingEnabled;
  @override
  @JsonKey()
  final bool signingRequired;

  @override
  String toString() {
    return 'SmbAuthResult(success: $success, error: $error, osVersion: $osVersion, netbiosName: $netbiosName, domain: $domain, isPdc: $isPdc, isDomainController: $isDomainController, signingEnabled: $signingEnabled, signingRequired: $signingRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmbAuthResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.netbiosName, netbiosName) ||
                other.netbiosName == netbiosName) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.isPdc, isPdc) || other.isPdc == isPdc) &&
            (identical(other.isDomainController, isDomainController) ||
                other.isDomainController == isDomainController) &&
            (identical(other.signingEnabled, signingEnabled) ||
                other.signingEnabled == signingEnabled) &&
            (identical(other.signingRequired, signingRequired) ||
                other.signingRequired == signingRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    error,
    osVersion,
    netbiosName,
    domain,
    isPdc,
    isDomainController,
    signingEnabled,
    signingRequired,
  );

  /// Create a copy of SmbAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmbAuthResultImplCopyWith<_$SmbAuthResultImpl> get copyWith =>
      __$$SmbAuthResultImplCopyWithImpl<_$SmbAuthResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmbAuthResultImplToJson(this);
  }
}

abstract class _SmbAuthResult implements SmbAuthResult {
  const factory _SmbAuthResult({
    required final bool success,
    final String? error,
    final String? osVersion,
    final String? netbiosName,
    final String? domain,
    final bool isPdc,
    final bool isDomainController,
    final bool signingEnabled,
    final bool signingRequired,
  }) = _$SmbAuthResultImpl;

  factory _SmbAuthResult.fromJson(Map<String, dynamic> json) =
      _$SmbAuthResultImpl.fromJson;

  @override
  bool get success;
  @override
  String? get error;
  @override
  String? get osVersion;
  @override
  String? get netbiosName;
  @override
  String? get domain;
  @override
  bool get isPdc;
  @override
  bool get isDomainController;
  @override
  bool get signingEnabled;
  @override
  bool get signingRequired;

  /// Create a copy of SmbAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmbAuthResultImplCopyWith<_$SmbAuthResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmbShare _$SmbShareFromJson(Map<String, dynamic> json) {
  return _SmbShare.fromJson(json);
}

/// @nodoc
mixin _$SmbShare {
  String get name => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // DISK, IPC, PRINT, etc.
  String? get remark => throw _privateConstructorUsedError;

  /// Serializes this SmbShare to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmbShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmbShareCopyWith<SmbShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmbShareCopyWith<$Res> {
  factory $SmbShareCopyWith(SmbShare value, $Res Function(SmbShare) then) =
      _$SmbShareCopyWithImpl<$Res, SmbShare>;
  @useResult
  $Res call({String name, String type, String? remark});
}

/// @nodoc
class _$SmbShareCopyWithImpl<$Res, $Val extends SmbShare>
    implements $SmbShareCopyWith<$Res> {
  _$SmbShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmbShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? remark = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            remark: freezed == remark
                ? _value.remark
                : remark // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmbShareImplCopyWith<$Res>
    implements $SmbShareCopyWith<$Res> {
  factory _$$SmbShareImplCopyWith(
    _$SmbShareImpl value,
    $Res Function(_$SmbShareImpl) then,
  ) = __$$SmbShareImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type, String? remark});
}

/// @nodoc
class __$$SmbShareImplCopyWithImpl<$Res>
    extends _$SmbShareCopyWithImpl<$Res, _$SmbShareImpl>
    implements _$$SmbShareImplCopyWith<$Res> {
  __$$SmbShareImplCopyWithImpl(
    _$SmbShareImpl _value,
    $Res Function(_$SmbShareImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmbShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? remark = freezed,
  }) {
    return _then(
      _$SmbShareImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        remark: freezed == remark
            ? _value.remark
            : remark // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmbShareImpl implements _SmbShare {
  const _$SmbShareImpl({required this.name, required this.type, this.remark});

  factory _$SmbShareImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmbShareImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  // DISK, IPC, PRINT, etc.
  @override
  final String? remark;

  @override
  String toString() {
    return 'SmbShare(name: $name, type: $type, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmbShareImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, remark);

  /// Create a copy of SmbShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmbShareImplCopyWith<_$SmbShareImpl> get copyWith =>
      __$$SmbShareImplCopyWithImpl<_$SmbShareImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmbShareImplToJson(this);
  }
}

abstract class _SmbShare implements SmbShare {
  const factory _SmbShare({
    required final String name,
    required final String type,
    final String? remark,
  }) = _$SmbShareImpl;

  factory _SmbShare.fromJson(Map<String, dynamic> json) =
      _$SmbShareImpl.fromJson;

  @override
  String get name;
  @override
  String get type; // DISK, IPC, PRINT, etc.
  @override
  String? get remark;

  /// Create a copy of SmbShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmbShareImplCopyWith<_$SmbShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmbDirEntry _$SmbDirEntryFromJson(Map<String, dynamic> json) {
  return _SmbDirEntry.fromJson(json);
}

/// @nodoc
mixin _$SmbDirEntry {
  String get name => throw _privateConstructorUsedError;
  bool get isDirectory => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  DateTime get lastModified => throw _privateConstructorUsedError;

  /// Serializes this SmbDirEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmbDirEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmbDirEntryCopyWith<SmbDirEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmbDirEntryCopyWith<$Res> {
  factory $SmbDirEntryCopyWith(
    SmbDirEntry value,
    $Res Function(SmbDirEntry) then,
  ) = _$SmbDirEntryCopyWithImpl<$Res, SmbDirEntry>;
  @useResult
  $Res call({String name, bool isDirectory, int size, DateTime lastModified});
}

/// @nodoc
class _$SmbDirEntryCopyWithImpl<$Res, $Val extends SmbDirEntry>
    implements $SmbDirEntryCopyWith<$Res> {
  _$SmbDirEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmbDirEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isDirectory = null,
    Object? size = null,
    Object? lastModified = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            isDirectory: null == isDirectory
                ? _value.isDirectory
                : isDirectory // ignore: cast_nullable_to_non_nullable
                      as bool,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            lastModified: null == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmbDirEntryImplCopyWith<$Res>
    implements $SmbDirEntryCopyWith<$Res> {
  factory _$$SmbDirEntryImplCopyWith(
    _$SmbDirEntryImpl value,
    $Res Function(_$SmbDirEntryImpl) then,
  ) = __$$SmbDirEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, bool isDirectory, int size, DateTime lastModified});
}

/// @nodoc
class __$$SmbDirEntryImplCopyWithImpl<$Res>
    extends _$SmbDirEntryCopyWithImpl<$Res, _$SmbDirEntryImpl>
    implements _$$SmbDirEntryImplCopyWith<$Res> {
  __$$SmbDirEntryImplCopyWithImpl(
    _$SmbDirEntryImpl _value,
    $Res Function(_$SmbDirEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmbDirEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isDirectory = null,
    Object? size = null,
    Object? lastModified = null,
  }) {
    return _then(
      _$SmbDirEntryImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        isDirectory: null == isDirectory
            ? _value.isDirectory
            : isDirectory // ignore: cast_nullable_to_non_nullable
                  as bool,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        lastModified: null == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmbDirEntryImpl implements _SmbDirEntry {
  const _$SmbDirEntryImpl({
    required this.name,
    required this.isDirectory,
    required this.size,
    required this.lastModified,
  });

  factory _$SmbDirEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmbDirEntryImplFromJson(json);

  @override
  final String name;
  @override
  final bool isDirectory;
  @override
  final int size;
  @override
  final DateTime lastModified;

  @override
  String toString() {
    return 'SmbDirEntry(name: $name, isDirectory: $isDirectory, size: $size, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmbDirEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDirectory, isDirectory) ||
                other.isDirectory == isDirectory) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, isDirectory, size, lastModified);

  /// Create a copy of SmbDirEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmbDirEntryImplCopyWith<_$SmbDirEntryImpl> get copyWith =>
      __$$SmbDirEntryImplCopyWithImpl<_$SmbDirEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmbDirEntryImplToJson(this);
  }
}

abstract class _SmbDirEntry implements SmbDirEntry {
  const factory _SmbDirEntry({
    required final String name,
    required final bool isDirectory,
    required final int size,
    required final DateTime lastModified,
  }) = _$SmbDirEntryImpl;

  factory _SmbDirEntry.fromJson(Map<String, dynamic> json) =
      _$SmbDirEntryImpl.fromJson;

  @override
  String get name;
  @override
  bool get isDirectory;
  @override
  int get size;
  @override
  DateTime get lastModified;

  /// Create a copy of SmbDirEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmbDirEntryImplCopyWith<_$SmbDirEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmbAccessResult _$SmbAccessResultFromJson(Map<String, dynamic> json) {
  return _SmbAccessResult.fromJson(json);
}

/// @nodoc
mixin _$SmbAccessResult {
  bool get readable => throw _privateConstructorUsedError;
  bool get writable => throw _privateConstructorUsedError;

  /// Serializes this SmbAccessResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmbAccessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmbAccessResultCopyWith<SmbAccessResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmbAccessResultCopyWith<$Res> {
  factory $SmbAccessResultCopyWith(
    SmbAccessResult value,
    $Res Function(SmbAccessResult) then,
  ) = _$SmbAccessResultCopyWithImpl<$Res, SmbAccessResult>;
  @useResult
  $Res call({bool readable, bool writable});
}

/// @nodoc
class _$SmbAccessResultCopyWithImpl<$Res, $Val extends SmbAccessResult>
    implements $SmbAccessResultCopyWith<$Res> {
  _$SmbAccessResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmbAccessResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readable = null, Object? writable = null}) {
    return _then(
      _value.copyWith(
            readable: null == readable
                ? _value.readable
                : readable // ignore: cast_nullable_to_non_nullable
                      as bool,
            writable: null == writable
                ? _value.writable
                : writable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmbAccessResultImplCopyWith<$Res>
    implements $SmbAccessResultCopyWith<$Res> {
  factory _$$SmbAccessResultImplCopyWith(
    _$SmbAccessResultImpl value,
    $Res Function(_$SmbAccessResultImpl) then,
  ) = __$$SmbAccessResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool readable, bool writable});
}

/// @nodoc
class __$$SmbAccessResultImplCopyWithImpl<$Res>
    extends _$SmbAccessResultCopyWithImpl<$Res, _$SmbAccessResultImpl>
    implements _$$SmbAccessResultImplCopyWith<$Res> {
  __$$SmbAccessResultImplCopyWithImpl(
    _$SmbAccessResultImpl _value,
    $Res Function(_$SmbAccessResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmbAccessResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? readable = null, Object? writable = null}) {
    return _then(
      _$SmbAccessResultImpl(
        readable: null == readable
            ? _value.readable
            : readable // ignore: cast_nullable_to_non_nullable
                  as bool,
        writable: null == writable
            ? _value.writable
            : writable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmbAccessResultImpl implements _SmbAccessResult {
  const _$SmbAccessResultImpl({required this.readable, required this.writable});

  factory _$SmbAccessResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmbAccessResultImplFromJson(json);

  @override
  final bool readable;
  @override
  final bool writable;

  @override
  String toString() {
    return 'SmbAccessResult(readable: $readable, writable: $writable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmbAccessResultImpl &&
            (identical(other.readable, readable) ||
                other.readable == readable) &&
            (identical(other.writable, writable) ||
                other.writable == writable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, readable, writable);

  /// Create a copy of SmbAccessResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmbAccessResultImplCopyWith<_$SmbAccessResultImpl> get copyWith =>
      __$$SmbAccessResultImplCopyWithImpl<_$SmbAccessResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SmbAccessResultImplToJson(this);
  }
}

abstract class _SmbAccessResult implements SmbAccessResult {
  const factory _SmbAccessResult({
    required final bool readable,
    required final bool writable,
  }) = _$SmbAccessResultImpl;

  factory _SmbAccessResult.fromJson(Map<String, dynamic> json) =
      _$SmbAccessResultImpl.fromJson;

  @override
  bool get readable;
  @override
  bool get writable;

  /// Create a copy of SmbAccessResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmbAccessResultImplCopyWith<_$SmbAccessResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
