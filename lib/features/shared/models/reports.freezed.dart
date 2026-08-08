// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShareAccessReport _$ShareAccessReportFromJson(Map<String, dynamic> json) {
  return _ShareAccessReport.fromJson(json);
}

/// @nodoc
mixin _$ShareAccessReport {
  String get shareName => throw _privateConstructorUsedError;
  String get accessLevel =>
      throw _privateConstructorUsedError; // READ, WRITE, DENIED
  int get itemCount => throw _privateConstructorUsedError;
  List<String> get sampleFiles => throw _privateConstructorUsedError;

  /// Serializes this ShareAccessReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShareAccessReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShareAccessReportCopyWith<ShareAccessReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareAccessReportCopyWith<$Res> {
  factory $ShareAccessReportCopyWith(
    ShareAccessReport value,
    $Res Function(ShareAccessReport) then,
  ) = _$ShareAccessReportCopyWithImpl<$Res, ShareAccessReport>;
  @useResult
  $Res call({
    String shareName,
    String accessLevel,
    int itemCount,
    List<String> sampleFiles,
  });
}

/// @nodoc
class _$ShareAccessReportCopyWithImpl<$Res, $Val extends ShareAccessReport>
    implements $ShareAccessReportCopyWith<$Res> {
  _$ShareAccessReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShareAccessReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareName = null,
    Object? accessLevel = null,
    Object? itemCount = null,
    Object? sampleFiles = null,
  }) {
    return _then(
      _value.copyWith(
            shareName: null == shareName
                ? _value.shareName
                : shareName // ignore: cast_nullable_to_non_nullable
                      as String,
            accessLevel: null == accessLevel
                ? _value.accessLevel
                : accessLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            itemCount: null == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int,
            sampleFiles: null == sampleFiles
                ? _value.sampleFiles
                : sampleFiles // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShareAccessReportImplCopyWith<$Res>
    implements $ShareAccessReportCopyWith<$Res> {
  factory _$$ShareAccessReportImplCopyWith(
    _$ShareAccessReportImpl value,
    $Res Function(_$ShareAccessReportImpl) then,
  ) = __$$ShareAccessReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String shareName,
    String accessLevel,
    int itemCount,
    List<String> sampleFiles,
  });
}

/// @nodoc
class __$$ShareAccessReportImplCopyWithImpl<$Res>
    extends _$ShareAccessReportCopyWithImpl<$Res, _$ShareAccessReportImpl>
    implements _$$ShareAccessReportImplCopyWith<$Res> {
  __$$ShareAccessReportImplCopyWithImpl(
    _$ShareAccessReportImpl _value,
    $Res Function(_$ShareAccessReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShareAccessReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareName = null,
    Object? accessLevel = null,
    Object? itemCount = null,
    Object? sampleFiles = null,
  }) {
    return _then(
      _$ShareAccessReportImpl(
        shareName: null == shareName
            ? _value.shareName
            : shareName // ignore: cast_nullable_to_non_nullable
                  as String,
        accessLevel: null == accessLevel
            ? _value.accessLevel
            : accessLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        itemCount: null == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sampleFiles: null == sampleFiles
            ? _value._sampleFiles
            : sampleFiles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareAccessReportImpl implements _ShareAccessReport {
  const _$ShareAccessReportImpl({
    required this.shareName,
    required this.accessLevel,
    required this.itemCount,
    final List<String> sampleFiles = const [],
  }) : _sampleFiles = sampleFiles;

  factory _$ShareAccessReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareAccessReportImplFromJson(json);

  @override
  final String shareName;
  @override
  final String accessLevel;
  // READ, WRITE, DENIED
  @override
  final int itemCount;
  final List<String> _sampleFiles;
  @override
  @JsonKey()
  List<String> get sampleFiles {
    if (_sampleFiles is EqualUnmodifiableListView) return _sampleFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sampleFiles);
  }

  @override
  String toString() {
    return 'ShareAccessReport(shareName: $shareName, accessLevel: $accessLevel, itemCount: $itemCount, sampleFiles: $sampleFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareAccessReportImpl &&
            (identical(other.shareName, shareName) ||
                other.shareName == shareName) &&
            (identical(other.accessLevel, accessLevel) ||
                other.accessLevel == accessLevel) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            const DeepCollectionEquality().equals(
              other._sampleFiles,
              _sampleFiles,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    shareName,
    accessLevel,
    itemCount,
    const DeepCollectionEquality().hash(_sampleFiles),
  );

  /// Create a copy of ShareAccessReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareAccessReportImplCopyWith<_$ShareAccessReportImpl> get copyWith =>
      __$$ShareAccessReportImplCopyWithImpl<_$ShareAccessReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareAccessReportImplToJson(this);
  }
}

abstract class _ShareAccessReport implements ShareAccessReport {
  const factory _ShareAccessReport({
    required final String shareName,
    required final String accessLevel,
    required final int itemCount,
    final List<String> sampleFiles,
  }) = _$ShareAccessReportImpl;

  factory _ShareAccessReport.fromJson(Map<String, dynamic> json) =
      _$ShareAccessReportImpl.fromJson;

  @override
  String get shareName;
  @override
  String get accessLevel; // READ, WRITE, DENIED
  @override
  int get itemCount;
  @override
  List<String> get sampleFiles;

  /// Create a copy of ShareAccessReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShareAccessReportImplCopyWith<_$ShareAccessReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WinrmPermissionReport _$WinrmPermissionReportFromJson(
  Map<String, dynamic> json,
) {
  return _WinrmPermissionReport.fromJson(json);
}

/// @nodoc
mixin _$WinrmPermissionReport {
  String get username => throw _privateConstructorUsedError;
  String get sid => throw _privateConstructorUsedError;
  List<String> get groups => throw _privateConstructorUsedError;
  List<String> get privileges => throw _privateConstructorUsedError;

  /// Serializes this WinrmPermissionReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WinrmPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WinrmPermissionReportCopyWith<WinrmPermissionReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WinrmPermissionReportCopyWith<$Res> {
  factory $WinrmPermissionReportCopyWith(
    WinrmPermissionReport value,
    $Res Function(WinrmPermissionReport) then,
  ) = _$WinrmPermissionReportCopyWithImpl<$Res, WinrmPermissionReport>;
  @useResult
  $Res call({
    String username,
    String sid,
    List<String> groups,
    List<String> privileges,
  });
}

/// @nodoc
class _$WinrmPermissionReportCopyWithImpl<
  $Res,
  $Val extends WinrmPermissionReport
>
    implements $WinrmPermissionReportCopyWith<$Res> {
  _$WinrmPermissionReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WinrmPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? sid = null,
    Object? groups = null,
    Object? privileges = null,
  }) {
    return _then(
      _value.copyWith(
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            sid: null == sid
                ? _value.sid
                : sid // ignore: cast_nullable_to_non_nullable
                      as String,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            privileges: null == privileges
                ? _value.privileges
                : privileges // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WinrmPermissionReportImplCopyWith<$Res>
    implements $WinrmPermissionReportCopyWith<$Res> {
  factory _$$WinrmPermissionReportImplCopyWith(
    _$WinrmPermissionReportImpl value,
    $Res Function(_$WinrmPermissionReportImpl) then,
  ) = __$$WinrmPermissionReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String username,
    String sid,
    List<String> groups,
    List<String> privileges,
  });
}

/// @nodoc
class __$$WinrmPermissionReportImplCopyWithImpl<$Res>
    extends
        _$WinrmPermissionReportCopyWithImpl<$Res, _$WinrmPermissionReportImpl>
    implements _$$WinrmPermissionReportImplCopyWith<$Res> {
  __$$WinrmPermissionReportImplCopyWithImpl(
    _$WinrmPermissionReportImpl _value,
    $Res Function(_$WinrmPermissionReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WinrmPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? sid = null,
    Object? groups = null,
    Object? privileges = null,
  }) {
    return _then(
      _$WinrmPermissionReportImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        sid: null == sid
            ? _value.sid
            : sid // ignore: cast_nullable_to_non_nullable
                  as String,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        privileges: null == privileges
            ? _value._privileges
            : privileges // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WinrmPermissionReportImpl implements _WinrmPermissionReport {
  const _$WinrmPermissionReportImpl({
    required this.username,
    required this.sid,
    final List<String> groups = const [],
    final List<String> privileges = const [],
  }) : _groups = groups,
       _privileges = privileges;

  factory _$WinrmPermissionReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$WinrmPermissionReportImplFromJson(json);

  @override
  final String username;
  @override
  final String sid;
  final List<String> _groups;
  @override
  @JsonKey()
  List<String> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  final List<String> _privileges;
  @override
  @JsonKey()
  List<String> get privileges {
    if (_privileges is EqualUnmodifiableListView) return _privileges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_privileges);
  }

  @override
  String toString() {
    return 'WinrmPermissionReport(username: $username, sid: $sid, groups: $groups, privileges: $privileges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WinrmPermissionReportImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.sid, sid) || other.sid == sid) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(
              other._privileges,
              _privileges,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    username,
    sid,
    const DeepCollectionEquality().hash(_groups),
    const DeepCollectionEquality().hash(_privileges),
  );

  /// Create a copy of WinrmPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WinrmPermissionReportImplCopyWith<_$WinrmPermissionReportImpl>
  get copyWith =>
      __$$WinrmPermissionReportImplCopyWithImpl<_$WinrmPermissionReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WinrmPermissionReportImplToJson(this);
  }
}

abstract class _WinrmPermissionReport implements WinrmPermissionReport {
  const factory _WinrmPermissionReport({
    required final String username,
    required final String sid,
    final List<String> groups,
    final List<String> privileges,
  }) = _$WinrmPermissionReportImpl;

  factory _WinrmPermissionReport.fromJson(Map<String, dynamic> json) =
      _$WinrmPermissionReportImpl.fromJson;

  @override
  String get username;
  @override
  String get sid;
  @override
  List<String> get groups;
  @override
  List<String> get privileges;

  /// Create a copy of WinrmPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WinrmPermissionReportImplCopyWith<_$WinrmPermissionReportImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LdapGroupInfo _$LdapGroupInfoFromJson(Map<String, dynamic> json) {
  return _LdapGroupInfo.fromJson(json);
}

/// @nodoc
mixin _$LdapGroupInfo {
  String get name => throw _privateConstructorUsedError;
  String get dn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  bool get isHighPrivilege => throw _privateConstructorUsedError;

  /// Serializes this LdapGroupInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LdapGroupInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LdapGroupInfoCopyWith<LdapGroupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LdapGroupInfoCopyWith<$Res> {
  factory $LdapGroupInfoCopyWith(
    LdapGroupInfo value,
    $Res Function(LdapGroupInfo) then,
  ) = _$LdapGroupInfoCopyWithImpl<$Res, LdapGroupInfo>;
  @useResult
  $Res call({
    String name,
    String dn,
    String? description,
    int memberCount,
    bool isHighPrivilege,
  });
}

/// @nodoc
class _$LdapGroupInfoCopyWithImpl<$Res, $Val extends LdapGroupInfo>
    implements $LdapGroupInfoCopyWith<$Res> {
  _$LdapGroupInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LdapGroupInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dn = null,
    Object? description = freezed,
    Object? memberCount = null,
    Object? isHighPrivilege = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            dn: null == dn
                ? _value.dn
                : dn // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            memberCount: null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isHighPrivilege: null == isHighPrivilege
                ? _value.isHighPrivilege
                : isHighPrivilege // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LdapGroupInfoImplCopyWith<$Res>
    implements $LdapGroupInfoCopyWith<$Res> {
  factory _$$LdapGroupInfoImplCopyWith(
    _$LdapGroupInfoImpl value,
    $Res Function(_$LdapGroupInfoImpl) then,
  ) = __$$LdapGroupInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String dn,
    String? description,
    int memberCount,
    bool isHighPrivilege,
  });
}

/// @nodoc
class __$$LdapGroupInfoImplCopyWithImpl<$Res>
    extends _$LdapGroupInfoCopyWithImpl<$Res, _$LdapGroupInfoImpl>
    implements _$$LdapGroupInfoImplCopyWith<$Res> {
  __$$LdapGroupInfoImplCopyWithImpl(
    _$LdapGroupInfoImpl _value,
    $Res Function(_$LdapGroupInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LdapGroupInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dn = null,
    Object? description = freezed,
    Object? memberCount = null,
    Object? isHighPrivilege = null,
  }) {
    return _then(
      _$LdapGroupInfoImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dn: null == dn
            ? _value.dn
            : dn // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        memberCount: null == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isHighPrivilege: null == isHighPrivilege
            ? _value.isHighPrivilege
            : isHighPrivilege // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LdapGroupInfoImpl implements _LdapGroupInfo {
  const _$LdapGroupInfoImpl({
    required this.name,
    required this.dn,
    this.description,
    required this.memberCount,
    this.isHighPrivilege = false,
  });

  factory _$LdapGroupInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LdapGroupInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String dn;
  @override
  final String? description;
  @override
  final int memberCount;
  @override
  @JsonKey()
  final bool isHighPrivilege;

  @override
  String toString() {
    return 'LdapGroupInfo(name: $name, dn: $dn, description: $description, memberCount: $memberCount, isHighPrivilege: $isHighPrivilege)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LdapGroupInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dn, dn) || other.dn == dn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.isHighPrivilege, isHighPrivilege) ||
                other.isHighPrivilege == isHighPrivilege));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    dn,
    description,
    memberCount,
    isHighPrivilege,
  );

  /// Create a copy of LdapGroupInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LdapGroupInfoImplCopyWith<_$LdapGroupInfoImpl> get copyWith =>
      __$$LdapGroupInfoImplCopyWithImpl<_$LdapGroupInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LdapGroupInfoImplToJson(this);
  }
}

abstract class _LdapGroupInfo implements LdapGroupInfo {
  const factory _LdapGroupInfo({
    required final String name,
    required final String dn,
    final String? description,
    required final int memberCount,
    final bool isHighPrivilege,
  }) = _$LdapGroupInfoImpl;

  factory _LdapGroupInfo.fromJson(Map<String, dynamic> json) =
      _$LdapGroupInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get dn;
  @override
  String? get description;
  @override
  int get memberCount;
  @override
  bool get isHighPrivilege;

  /// Create a copy of LdapGroupInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LdapGroupInfoImplCopyWith<_$LdapGroupInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SshPermissionReport _$SshPermissionReportFromJson(Map<String, dynamic> json) {
  return _SshPermissionReport.fromJson(json);
}

/// @nodoc
mixin _$SshPermissionReport {
  String get uid => throw _privateConstructorUsedError;
  String get gid => throw _privateConstructorUsedError;
  List<String> get groups => throw _privateConstructorUsedError;
  List<String> get sudoCommands => throw _privateConstructorUsedError;

  /// Serializes this SshPermissionReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SshPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SshPermissionReportCopyWith<SshPermissionReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SshPermissionReportCopyWith<$Res> {
  factory $SshPermissionReportCopyWith(
    SshPermissionReport value,
    $Res Function(SshPermissionReport) then,
  ) = _$SshPermissionReportCopyWithImpl<$Res, SshPermissionReport>;
  @useResult
  $Res call({
    String uid,
    String gid,
    List<String> groups,
    List<String> sudoCommands,
  });
}

/// @nodoc
class _$SshPermissionReportCopyWithImpl<$Res, $Val extends SshPermissionReport>
    implements $SshPermissionReportCopyWith<$Res> {
  _$SshPermissionReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SshPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? gid = null,
    Object? groups = null,
    Object? sudoCommands = null,
  }) {
    return _then(
      _value.copyWith(
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            gid: null == gid
                ? _value.gid
                : gid // ignore: cast_nullable_to_non_nullable
                      as String,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            sudoCommands: null == sudoCommands
                ? _value.sudoCommands
                : sudoCommands // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SshPermissionReportImplCopyWith<$Res>
    implements $SshPermissionReportCopyWith<$Res> {
  factory _$$SshPermissionReportImplCopyWith(
    _$SshPermissionReportImpl value,
    $Res Function(_$SshPermissionReportImpl) then,
  ) = __$$SshPermissionReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uid,
    String gid,
    List<String> groups,
    List<String> sudoCommands,
  });
}

/// @nodoc
class __$$SshPermissionReportImplCopyWithImpl<$Res>
    extends _$SshPermissionReportCopyWithImpl<$Res, _$SshPermissionReportImpl>
    implements _$$SshPermissionReportImplCopyWith<$Res> {
  __$$SshPermissionReportImplCopyWithImpl(
    _$SshPermissionReportImpl _value,
    $Res Function(_$SshPermissionReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SshPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? gid = null,
    Object? groups = null,
    Object? sudoCommands = null,
  }) {
    return _then(
      _$SshPermissionReportImpl(
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        gid: null == gid
            ? _value.gid
            : gid // ignore: cast_nullable_to_non_nullable
                  as String,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sudoCommands: null == sudoCommands
            ? _value._sudoCommands
            : sudoCommands // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SshPermissionReportImpl implements _SshPermissionReport {
  const _$SshPermissionReportImpl({
    required this.uid,
    required this.gid,
    final List<String> groups = const [],
    final List<String> sudoCommands = const [],
  }) : _groups = groups,
       _sudoCommands = sudoCommands;

  factory _$SshPermissionReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$SshPermissionReportImplFromJson(json);

  @override
  final String uid;
  @override
  final String gid;
  final List<String> _groups;
  @override
  @JsonKey()
  List<String> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  final List<String> _sudoCommands;
  @override
  @JsonKey()
  List<String> get sudoCommands {
    if (_sudoCommands is EqualUnmodifiableListView) return _sudoCommands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sudoCommands);
  }

  @override
  String toString() {
    return 'SshPermissionReport(uid: $uid, gid: $gid, groups: $groups, sudoCommands: $sudoCommands)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SshPermissionReportImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.gid, gid) || other.gid == gid) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(
              other._sudoCommands,
              _sudoCommands,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    gid,
    const DeepCollectionEquality().hash(_groups),
    const DeepCollectionEquality().hash(_sudoCommands),
  );

  /// Create a copy of SshPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SshPermissionReportImplCopyWith<_$SshPermissionReportImpl> get copyWith =>
      __$$SshPermissionReportImplCopyWithImpl<_$SshPermissionReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SshPermissionReportImplToJson(this);
  }
}

abstract class _SshPermissionReport implements SshPermissionReport {
  const factory _SshPermissionReport({
    required final String uid,
    required final String gid,
    final List<String> groups,
    final List<String> sudoCommands,
  }) = _$SshPermissionReportImpl;

  factory _SshPermissionReport.fromJson(Map<String, dynamic> json) =
      _$SshPermissionReportImpl.fromJson;

  @override
  String get uid;
  @override
  String get gid;
  @override
  List<String> get groups;
  @override
  List<String> get sudoCommands;

  /// Create a copy of SshPermissionReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SshPermissionReportImplCopyWith<_$SshPermissionReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
