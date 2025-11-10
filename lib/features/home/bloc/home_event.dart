import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadCountries extends HomeEvent {}

class SearchCountries extends HomeEvent {
  final String query;
  const SearchCountries(this.query);
  @override
  List<Object?> get props => [query];
}