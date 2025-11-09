
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/local_storage_service.dart';
import '../../../data/models/favorite_country.dart';
import 'favorite_countries_event.dart';
import 'favorite_countries_state.dart';

class FavoritesCountriesBloc extends Bloc<FavoriteCountriesEvent, FavoriteCountriesState> {
  final LocalStorageService localStorage;

  FavoritesCountriesBloc({required this.localStorage}) : super(FavoriteCountriesLoading()) {
    on<LoadFavoriteCountriesEvent>(_onLoad);
    on<ToggleFavoriteCountriesEvent>(_onToggle);
    add(LoadFavoriteCountriesEvent());
  }

  void _onLoad(LoadFavoriteCountriesEvent event, Emitter emit) async {
    final favoriteCountries = await localStorage.loadFavorites();
    emit(FavoriteCountriesLoaded(favoriteCountries));
  }

  void _onToggle(ToggleFavoriteCountriesEvent event, Emitter emit) async {
    final currentState = state as FavoriteCountriesLoaded;
    final isFavorited = currentState.favoriteCountries.any((f) => f.cca2 == event.cca2);
    List<FavoriteCountry> updated;

    if (isFavorited) {
      updated = currentState.favoriteCountries.where((f) => f.cca2 != event.cca2).toList();
    } else {
      updated = [
        ...currentState.favoriteCountries,
        FavoriteCountry(
          cca2: event.country.cca2,
          name: event.country.name,
          flag: event.country.flag,
          capital: null,
        )
      ];
    }

    await localStorage.saveFavorites(updated);
    emit(FavoriteCountriesLoaded(updated));
  }
}