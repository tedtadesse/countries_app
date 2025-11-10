// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountrySummary _$CountrySummaryFromJson(Map<String, dynamic> json) {
  return _CountrySummary.fromJson(json);
}

/// @nodoc
mixin _$CountrySummary {
  String get name => throw _privateConstructorUsedError;
  String get flagPng => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  String get cca2 => throw _privateConstructorUsedError;

  /// Serializes this CountrySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountrySummaryCopyWith<CountrySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountrySummaryCopyWith<$Res> {
  factory $CountrySummaryCopyWith(
    CountrySummary value,
    $Res Function(CountrySummary) then,
  ) = _$CountrySummaryCopyWithImpl<$Res, CountrySummary>;
  @useResult
  $Res call({String name, String flagPng, int population, String cca2});
}

/// @nodoc
class _$CountrySummaryCopyWithImpl<$Res, $Val extends CountrySummary>
    implements $CountrySummaryCopyWith<$Res> {
  _$CountrySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flagPng = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            flagPng:
                null == flagPng
                    ? _value.flagPng
                    : flagPng // ignore: cast_nullable_to_non_nullable
                        as String,
            population:
                null == population
                    ? _value.population
                    : population // ignore: cast_nullable_to_non_nullable
                        as int,
            cca2:
                null == cca2
                    ? _value.cca2
                    : cca2 // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CountrySummaryImplCopyWith<$Res>
    implements $CountrySummaryCopyWith<$Res> {
  factory _$$CountrySummaryImplCopyWith(
    _$CountrySummaryImpl value,
    $Res Function(_$CountrySummaryImpl) then,
  ) = __$$CountrySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String flagPng, int population, String cca2});
}

/// @nodoc
class __$$CountrySummaryImplCopyWithImpl<$Res>
    extends _$CountrySummaryCopyWithImpl<$Res, _$CountrySummaryImpl>
    implements _$$CountrySummaryImplCopyWith<$Res> {
  __$$CountrySummaryImplCopyWithImpl(
    _$CountrySummaryImpl _value,
    $Res Function(_$CountrySummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? flagPng = null,
    Object? population = null,
    Object? cca2 = null,
  }) {
    return _then(
      _$CountrySummaryImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        flagPng:
            null == flagPng
                ? _value.flagPng
                : flagPng // ignore: cast_nullable_to_non_nullable
                    as String,
        population:
            null == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                    as int,
        cca2:
            null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountrySummaryImpl implements _CountrySummary {
  const _$CountrySummaryImpl({
    required this.name,
    required this.flagPng,
    required this.population,
    required this.cca2,
  });

  factory _$CountrySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountrySummaryImplFromJson(json);

  @override
  final String name;
  @override
  final String flagPng;
  @override
  final int population;
  @override
  final String cca2;

  @override
  String toString() {
    return 'CountrySummary(name: $name, flagPng: $flagPng, population: $population, cca2: $cca2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountrySummaryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flagPng, flagPng) || other.flagPng == flagPng) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, flagPng, population, cca2);

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountrySummaryImplCopyWith<_$CountrySummaryImpl> get copyWith =>
      __$$CountrySummaryImplCopyWithImpl<_$CountrySummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountrySummaryImplToJson(this);
  }
}

abstract class _CountrySummary implements CountrySummary {
  const factory _CountrySummary({
    required final String name,
    required final String flagPng,
    required final int population,
    required final String cca2,
  }) = _$CountrySummaryImpl;

  factory _CountrySummary.fromJson(Map<String, dynamic> json) =
      _$CountrySummaryImpl.fromJson;

  @override
  String get name;
  @override
  String get flagPng;
  @override
  int get population;
  @override
  String get cca2;

  /// Create a copy of CountrySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountrySummaryImplCopyWith<_$CountrySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
