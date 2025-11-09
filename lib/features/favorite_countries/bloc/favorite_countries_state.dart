
import 'package:equatable/equatable.dart';

import '../../../data/models/favorite_country.dart';

abstract class FavoriteCountriesState extends Equatable {}

class FavoriteCountriesLoading extends FavoriteCountriesState {
  @override
  List<Object?> get props => [];
}

class FavoriteCountriesLoaded extends FavoriteCountriesState {
  final List<FavoriteCountry> favoriteCountries;
  FavoriteCountriesLoaded(this.favoriteCountries);

  @override
  List<Object?> get props => [favoriteCountries];
}
