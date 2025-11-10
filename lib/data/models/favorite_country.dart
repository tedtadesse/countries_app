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

  factory FavoriteCountry.fromJson(Map<String, dynamic> json) {
    return FavoriteCountry(
      cca2: json['cca2'] as String,
      name: json['name'] as String,
      flag: json['flag'] as String,
      capital: json['capital'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'cca2': cca2,
    'name': name,
    'flag': flag,
    'capital': capital,
  };

  @override
  List<Object?> get props => [cca2, name, flag, capital];
}