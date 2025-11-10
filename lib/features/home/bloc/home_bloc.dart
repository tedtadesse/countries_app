import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/country_summary.dart';
import '../widgets/sort_button.dart'; // for SortOrder
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _api;
  List<CountrySummary> _all = [];

  HomeBloc(this._api) : super(HomeLoading()) {
    on<LoadCountries>(_load);
    on<SearchCountries>(_search,
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 400))
            .switchMap(mapper));
    on<ClearSearch>(_clearSearch);
    on<SortCountries>(_sort);
    add(LoadCountries());
  }

  Future<void> _load(LoadCountries _, Emitter<HomeState> emit) async {
    try {
      _all = await _api.getAllCountries();
      emit(_applySort(_all, _all, '', SortOrder.nameAsc));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _search(SearchCountries ev, Emitter<HomeState> emit) async {
    final q = ev.query.trim();
    if (q.isEmpty) {
      add(ClearSearch());
      return;
    }

    final currentSort = state is HomeLoaded ? (state as HomeLoaded).sortOrder : SortOrder.nameAsc;

    try {
      final results = await _api.searchCountries(q);
      emit(_applySort(_all, results, q, currentSort));
    } catch (e) {
      emit(HomeError('No countries found for "$q"'));
    }
  }


  Future<void> _clearSearch(ClearSearch _, Emitter<HomeState> emit) async {
    final current = state as HomeLoaded;
    emit(_applySort(_all, _all, '', current.sortOrder));
  }

  Future<void> _sort(SortCountries ev, Emitter<HomeState> emit) async {
    final current = state as HomeLoaded;
    emit(_applySort(_all, current.filtered, current.searchQuery, ev.sortOrder));
  }

  HomeLoaded _applySort(
      List<CountrySummary> all,
      List<CountrySummary> filtered,
      String query,
      SortOrder sortOrder,
      ) {
    final sortedFiltered = List<CountrySummary>.from(filtered)
      ..sort((a, b) {
        switch (sortOrder) {
          case SortOrder.nameAsc:
            return a.name.compareTo(b.name);
          case SortOrder.nameDesc:
            return b.name.compareTo(a.name);
          case SortOrder.populationDesc:
            return b.population.compareTo(a.population);
          case SortOrder.populationAsc:
            return a.population.compareTo(b.population);
        }
      });

    return HomeLoaded(
      all: all,
      filtered: sortedFiltered,
      searchQuery: query,
      sortOrder: sortOrder,
    );
  }
}