import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/favorite_country.dart';

class LocalStorageService {
  static const String _favoritesKey = 'favorites';

  Future<void> saveFavorites(List<FavoriteCountry> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((f) => {
      'cca2': f.cca2,
      'name': f.name,
      'flag': f.flag,
      'capital': f.capital,
    }).toList();
    await prefs.setString(_favoritesKey, json.encode(jsonList));
  }

  Future<List<FavoriteCountry>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => FavoriteCountry(
      cca2: json['cca2'],
      name: json['name'],
      flag: json['flag'],
      capital: json['capital'],
    )).toList();
  }
}