import 'package:equatable/equatable.dart';

abstract class CountryDetailEvent extends Equatable {
  const CountryDetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadDetail extends CountryDetailEvent {
  final String cca2;
  const LoadDetail(this.cca2);
  @override
  List<Object?> get props => [cca2];
}