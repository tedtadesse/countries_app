import 'package:equatable/equatable.dart';
import '../../../data/models/country_summary.dart';
import '../widgets/sort_button.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CountrySummary> all;
  final List<CountrySummary> filtered;
  final String searchQuery;
  final SortOrder sortOrder;

  const HomeLoaded({
    required this.all,
    required this.filtered,
    this.searchQuery = '',
    this.sortOrder = SortOrder.nameAsc,
  });

  HomeLoaded copyWith({
    List<CountrySummary>? all,
    List<CountrySummary>? filtered,
    String? searchQuery,
    SortOrder? sortOrder,
  }) {
    return HomeLoaded(
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [all, filtered, searchQuery, sortOrder];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}