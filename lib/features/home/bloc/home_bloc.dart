import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/country_summary.dart';
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

    add(LoadCountries());
  }

  Future<void> _load(LoadCountries _, Emitter<HomeState> emit) async {
    try {
      _all = await _api.getAllCountries();
      emit(HomeLoaded(all: _all, filtered: _all));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _search(SearchCountries ev, Emitter<HomeState> emit) async {
    final q = ev.query.toLowerCase();
    final filtered = _all
        .where((c) => c.name.toLowerCase().contains(q))
        .toList();
    emit(HomeLoaded(all: _all, filtered: filtered));
  }
}