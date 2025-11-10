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
  final String? capital;

  const ToggleFavorite(this.country, [this.capital]);

  @override
  List<Object?> get props => [country, capital];
}