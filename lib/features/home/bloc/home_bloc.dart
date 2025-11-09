import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/country_summary.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;
  List<CountrySummary> _allCountries = [];

  HomeBloc({required this.apiService}) : super(HomeLoading()) {
    on<LoadCountries>(_onLoadCountries);
    on<SearchCountries>(_onSearchCountries);
    add(LoadCountries());
  }

  void _onLoadCountries(LoadCountries event, Emitter<HomeState> emit) async {
    try {
      final countries = await apiService.getAllCountries();
      _allCountries = countries;
      emit(HomeLoaded(countries: countries, filteredCountries: countries));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onSearchCountries(SearchCountries event, Emitter<HomeState> emit) {
    if (_allCountries.isEmpty) return;
    final query = event.query.toLowerCase();
    final filtered = _allCountries
        .where((country) => country.name.toLowerCase().contains(query))
        .toList();
    emit(HomeLoaded(
      countries: _allCountries,
      filteredCountries: filtered,
    ));
  }
}