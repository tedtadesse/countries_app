import 'package:equatable/equatable.dart';
import '../../../data/models/country_summary.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final CountrySummary country;
  const ToggleFavorite(this.country);
  @override
  List<Object?> get props => [country.cca2];
}