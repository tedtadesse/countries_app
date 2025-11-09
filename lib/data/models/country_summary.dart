import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'country_summary.freezed.dart';
part 'country_summary.g.dart';

@freezed
class CountrySummary with _$CountrySummary {
  const factory CountrySummary({
    required String name,
    required String flag,
    required int population,
    required String cca2,
  }) = _CountrySummary;

  factory CountrySummary.fromJson(Map<String, dynamic> json) => _$CountrySummaryFromJson(json);
}