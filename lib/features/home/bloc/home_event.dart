import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadCountries extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SearchCountries extends HomeEvent {
  final String query;
  const SearchCountries(this.query);

  @override
  List<Object?> get props => [query];
}