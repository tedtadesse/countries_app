import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'country_details.freezed.dart';
part 'country_details.g.dart';

@freezed
class CountryDetails with _$CountryDetails {
  const factory CountryDetails({
    required String name,
    required String flag,
    required int population,
    String? capital,
    required String region,
    String? subregion,
    double? area,
    List<String>? timezones,
  }) = _CountryDetails;

  factory CountryDetails.fromJson(Map<String, dynamic> json) => _$CountryDetailsFromJson(json);
}