import 'package:equatable/equatable.dart';
import '../../../data/models/country_summary.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  final List<CountrySummary> countries;
  final List<CountrySummary> filteredCountries;
  final bool hasError;

  const HomeLoaded({
    required this.countries,
    required this.filteredCountries,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [countries, filteredCountries, hasError];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}