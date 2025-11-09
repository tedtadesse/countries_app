import 'package:equatable/equatable.dart';

import '../../../data/models/country_summary.dart';

abstract class FavoriteCountriesEvent extends Equatable {}

class LoadFavoriteCountriesEvent extends FavoriteCountriesEvent {
  @override
  List<Object?> get props => [];
}

class ToggleFavoriteCountriesEvent extends FavoriteCountriesEvent {
  final String cca2;
  final CountrySummary country;
  ToggleFavoriteCountriesEvent(this.cca2, this.country);

  @override
  List<Object?> get props => [cca2];
}