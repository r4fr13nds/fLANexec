import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_info.freezed.dart';
part 'service_info.g.dart';

@freezed
class ServiceInfo with _$ServiceInfo {
  const factory ServiceInfo({
    required String host,
    required int port,
    required String service,
    String? product,
    String? version,
    String? extraInfo,
    String? osGuess,
    @Default({}) Map<String, String> scripts,
    required String rawOutput,
  }) = _ServiceInfo;

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => _$ServiceInfoFromJson(json);
}
