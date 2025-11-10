import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_service.dart';
import 'country_detail_event.dart';
import 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final ApiService _api;
  String? cca2;

  CountryDetailBloc(this._api) : super(DetailLoading()) {
    on<LoadDetail>(_load);
  }

  Future<void> _load(LoadDetail ev, Emitter<CountryDetailState> emit) async {
    cca2 = ev.cca2;
    emit(DetailLoading());

    try {
      final data = await _api.getCountryDetails(ev.cca2);
      emit(DetailLoaded(data));
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }
}