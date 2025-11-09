import 'package:equatable/equatable.dart';

class FavoriteCountry extends Equatable {
  final String cca2;
  final String name;
  final String flag;
  final String? capital;

  const FavoriteCountry({
    required this.cca2,
    required this.name,
    required this.flag,
    this.capital,
  });

  @override
  List<Object?> get props => [cca2, name, flag, capital];
}