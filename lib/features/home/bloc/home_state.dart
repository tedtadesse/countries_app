import 'package:equatable/equatable.dart';
import '../../../data/models/country_summary.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CountrySummary> all;
  final List<CountrySummary> filtered;
  const HomeLoaded({required this.all, required this.filtered});
  @override
  List<Object?> get props => [all, filtered];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}