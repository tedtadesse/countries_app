import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_service.dart';
import '../../../core/models/country_details.dart';
import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ApiService apiService;

  DetailBloc({required this.apiService}) : super(DetailLoading()) {
    on<LoadDetails>(_onLoadDetails);
  }

  void _onLoadDetails(LoadDetails event, Emitter<DetailState> emit) async {
    try {
      final details = await apiService.getCountryDetails(event.cca2);
      emit(DetailLoaded(details));
    } catch (e) {
      emit(DetailError(e.toString()));
    }
  }
}