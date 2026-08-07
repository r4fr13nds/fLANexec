import 'package:freezed_annotation/freezed_annotation.dart';

part 'smb_models.freezed.dart';
part 'smb_models.g.dart';

@freezed
class SmbAuthResult with _$SmbAuthResult {
  const factory SmbAuthResult({
    required bool success,
    String? error,
    String? osVersion,
    String? netbiosName,
    String? domain,
    @Default(false) bool isPdc,
    @Default(false) bool isDomainController,
    @Default(false) bool signingEnabled,
    @Default(false) bool signingRequired,
  }) = _SmbAuthResult;

  factory SmbAuthResult.fromJson(Map<String, dynamic> json) => _$SmbAuthResultFromJson(json);
}

@freezed
class SmbShare with _$SmbShare {
  const factory SmbShare({
    required String name,
    required String type, // DISK, IPC, PRINT, etc.
    String? remark,
  }) = _SmbShare;

  factory SmbShare.fromJson(Map<String, dynamic> json) => _$SmbShareFromJson(json);
}

@freezed
class SmbDirEntry with _$SmbDirEntry {
  const factory SmbDirEntry({
    required String name,
    required bool isDirectory,
    required int size,
    required DateTime lastModified,
  }) = _SmbDirEntry;

  factory SmbDirEntry.fromJson(Map<String, dynamic> json) => _$SmbDirEntryFromJson(json);
}

@freezed
class SmbAccessResult with _$SmbAccessResult {
  const factory SmbAccessResult({
    required bool readable,
    required bool writable,
  }) = _SmbAccessResult;

  factory SmbAccessResult.fromJson(Map<String, dynamic> json) => _$SmbAccessResultFromJson(json);
}
