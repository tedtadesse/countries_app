import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary.freezed.dart';
part 'country_summary.g.dart';

@freezed
class CountrySummary with _$CountrySummary {
  const factory CountrySummary({
    required String name,
    required String flagPng,
    required int population,
    required String cca2,
  }) = _CountrySummary;

  factory CountrySummary.fromJson(Map<String, dynamic> json) =>
      _$CountrySummaryFromJson(json);

  static CountrySummary fromApiJson(Map<String, dynamic> json) {
    final nameObj = json['name'] as Map<String, dynamic>;
    final flagsObj = json['flags'] as Map<String, dynamic>;

    return CountrySummary(
      name: nameObj['common'] as String,
      flagPng: flagsObj['png'] as String,
      population: json['population'] as int,
      cca2: json['cca2'] as String,
    );
  }
}
