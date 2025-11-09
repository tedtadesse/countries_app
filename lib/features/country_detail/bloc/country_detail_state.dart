import 'package:equatable/equatable.dart';
import '../../../core/models/country_details.dart';
import '../../../data/models/country_details.dart';

abstract class CountryDetailState extends Equatable {
  const CountryDetailState();
}

class CountryDetailLoading extends CountryDetailState {
  @override
  List<Object?> get props => [];
}

class CountryDetailLoaded extends CountryDetailState {
  final CountryDetails details;
  const CountryDetailLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class CountryDetailError extends CountryDetailState {
  final String message;
  const CountryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}