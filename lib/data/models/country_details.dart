import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_details.freezed.dart';
// part 'country_details.g.dart';

@freezed
class CountryDetails with _$CountryDetails {
  const factory CountryDetails({
    required String name,
    required String flag,
    required int population,
    required String cca2,
    String? capital,
    required String region,
    String? subregion,
    double? area,
    List<String>? timezones,
  }) = _CountryDetails;

  static CountryDetails fromJson(Map<String, dynamic> json) {
    final nameObj = json['name'] as Map<String, dynamic>;
    final flagsObj = json['flags'] as Map<String, dynamic>;
    final capitalList = json['capital'] as List<dynamic>?;

    return CountryDetails(
      name: nameObj['common'] as String,
      flag: flagsObj['png'] as String,
      population: json['population'] as int,
      cca2: json['cca2'] as String,
      capital: capitalList?.isNotEmpty == true ? capitalList!.first as String : null,
      region: json['region'] as String,
      subregion: json['subregion'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      timezones: (json['timezones'] as List<dynamic>?)?.cast<String>(),
    );
  }
}