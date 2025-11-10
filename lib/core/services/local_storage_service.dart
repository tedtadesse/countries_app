import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/favorite_country.dart';

class LocalStorageService {
  static const _key = 'favorite_countries';

  Future<void> save(List<FavoriteCountry> favs) async {
    final prefs = await SharedPreferences.getInstance();
    final json = favs
        .map((e) => {
      'cca2': e.cca2,
      'name': e.name,
      'flag': e.flag,
      'capital': e.capital,
    })
        .toList();
    await prefs.setString(_key, jsonEncode(json));
  }

  Future<List<FavoriteCountry>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];

    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map<FavoriteCountry>((e) {
        final map = e as Map<String, dynamic>;
        return FavoriteCountry(
          cca2: map['cca2'] as String,
          name: map['name'] as String,
          flag: map['flag'] as String,
          capital: map['capital'] as String?,
        );
      }).toList();
    } catch (e) {
      print('Corrupted favorites data: $e');
      await prefs.remove(_key);
      return [];
    }
  }
}