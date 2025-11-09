import 'package:equatable/equatable.dart';

abstract class CountryDetailEvent extends Equatable {
  const CountryDetailEvent();
}

class LoadCountryDetails extends CountryDetailEvent {
  final String cca2;
  const LoadCountryDetails(this.cca2);

  @override
  List<Object?> get props => [cca2];
}