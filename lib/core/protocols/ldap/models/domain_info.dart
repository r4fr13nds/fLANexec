import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain_info.freezed.dart';
part 'domain_info.g.dart';

@freezed
class DomainInfo with _$DomainInfo {
  const factory DomainInfo({
    String? domain,
    String? forest,
    String? dnsHostName,
    String? serverDn,
    @Default(false) bool isGlobalCatalog,
    int? functionalLevel,
    @Default([]) List<String> supportedMechs,
  }) = _DomainInfo;

  factory DomainInfo.fromJson(Map<String, dynamic> json) => _$DomainInfoFromJson(json);
}
