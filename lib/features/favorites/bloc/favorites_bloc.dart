import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../data/models/country_summary.dart';
import '../../../data/models/favorite_country.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final LocalStorageService _storage;

  FavoritesBloc(this._storage) : super(FavoritesLoading()) {
    on<LoadFavorites>(_load);
    on<ToggleFavorite>(_toggle);
    add(LoadFavorites());
  }

  Future<void> _load(LoadFavorites _, Emitter<FavoritesState> emit) async {
    try {
      final list = await _storage.load();
      emit(FavoritesLoaded(list));
    } catch (e) {
      emit(FavoritesLoaded([]));
    }
  }
  Future<void> _toggle(ToggleFavorite ev, Emitter<FavoritesState> emit) async {
    final current = (state as FavoritesLoaded).favorites;
    final exists = current.any((f) => f.cca2 == ev.country.cca2);
    final updated = exists
        ? current.where((f) => f.cca2 != ev.country.cca2).toList()
        : [
      ...current,
      FavoriteCountry(
        cca2: ev.country.cca2,
        name: ev.country.name,
        flag: ev.country.flagPng,
        capital: null,
      ),
    ];
    await _storage.save(updated);
    emit(FavoritesLoaded(updated));
  }
}