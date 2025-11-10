import 'package:equatable/equatable.dart';
import '../widgets/sort_button.dart';

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

class ClearSearch extends HomeEvent {}

class SortCountries extends HomeEvent {
  final SortOrder sortOrder;

  const SortCountries(this.sortOrder);

  @override
  List<Object?> get props => [sortOrder];
}
