import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_service.dart';
import 'country_detail_event.dart';
import 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final ApiService apiService;

  CountryDetailBloc({required this.apiService}) : super(CountryDetailLoading()) {
    on<LoadCountryDetails>(_onLoadDetails);
  }

  void _onLoadDetails(LoadCountryDetails event, Emitter<CountryDetailState> emit) async {
    try {
      final details = await apiService.getCountryDetails(event.cca2);
      emit(CountryDetailLoaded(details));
    } catch (e) {
      emit(CountryDetailError(e.toString()));
    }
  }
}