import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/country_details.dart';
import '../../data/models/country_summary.dart';

class ApiService {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<CountrySummary>> getAllCountries() async {
    final response = await http.get(Uri.parse('$baseUrl/all?fields=name,flags,population,cca2'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CountrySummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<CountrySummary>> searchCountries(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/name/$name?fields=name,flags,population,cca2'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CountrySummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search countries');
    }
  }

  Future<CountryDetails> getCountryDetails(String cca2) async {
    final response = await http.get(Uri.parse('$baseUrl/alpha/$cca2?fields=name,flags,population,capital,region,subregion,area,timezones'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)[0];
      return CountryDetails.fromJson(data);
    } else {
      throw Exception('Failed to load country details');
    }
  }
}