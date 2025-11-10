import 'package:equatable/equatable.dart';
import '../../../data/models/country_details.dart';

abstract class CountryDetailState extends Equatable {
  const CountryDetailState();
  @override
  List<Object?> get props => [];
}

class DetailLoading extends CountryDetailState {}

class DetailLoaded extends CountryDetailState {
  final CountryDetails details;
  const DetailLoaded(this.details);
  @override
  List<Object?> get props => [details];
}

class DetailError extends CountryDetailState {
  final String message;
  const DetailError(this.message);
  @override
  List<Object?> get props => [message];
}