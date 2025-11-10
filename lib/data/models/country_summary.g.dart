// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountrySummaryImpl _$$CountrySummaryImplFromJson(Map<String, dynamic> json) =>
    _$CountrySummaryImpl(
      name: json['name'] as String,
      flagPng: json['flagPng'] as String,
      population: (json['population'] as num).toInt(),
      cca2: json['cca2'] as String,
    );

Map<String, dynamic> _$$CountrySummaryImplToJson(
  _$CountrySummaryImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'flagPng': instance.flagPng,
  'population': instance.population,
  'cca2': instance.cca2,
};
