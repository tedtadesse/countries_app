import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http/http.dart' as http;

import '../../data/models/country_details.dart';
import '../../data/models/country_summary.dart';



  class ApiService {
  static const _base = 'https://restcountries.com/v3.1';
  late final Dio _dio;

  ApiService() {
  final cacheOptions = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.refreshForceCache,
  maxStale: const Duration(days: 7),
  );
  _dio = Dio(BaseOptions(baseUrl: _base))
  ..interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<List<CountrySummary>> getAllCountries() async {
  try {
  final response = await _dio.get(
  '/all?fields=name,flags,population,cca2',
  options: Options(
  responseType: ResponseType.json,
  ),
  );

  // Perform JSON parsing in an isolate or use compute()
  return await _parseCountries(response.data);
  } catch (e) {
  throw Exception('Failed to load countries: $e');
  }
  }

  Future<List<CountrySummary>> _parseCountries(dynamic data) async {
  // This runs in a separate microtask
  return await Future.microtask(() {
  return (data as List)
      .map((e) => CountrySummary.fromApiJson(e as Map<String, dynamic>))
      .toList();
  });
  }

  Future<List<CountrySummary>> searchCountries(String query) async {
    final resp = await _dio.get('/name/$query?fields=name,flags,population,cca2');

    print("Searched countries with query '$query', found ${(resp.data as List).length} results");

    return (resp.data as List)
        .map((e) => CountrySummary.fromApiJson(e as Map<String, dynamic>))
        .toList();
  }
  Future<CountryDetails> getCountryDetails(String cca2) async {
    try {
      final resp = await _dio.get(
        '/alpha/$cca2',
        queryParameters: {
          'fields': 'name,flags,population,cca2,capital,region,subregion,area,timezones'
        },
      );

      // Handle both array and object responses
      if (resp.data is List) {
        final List<dynamic> dataList = resp.data;
        if (dataList.isEmpty) {
          throw Exception('Country not found');
        }
        final json = dataList.first as Map<String, dynamic>;
        return CountryDetails.fromJson(json);
      } else if (resp.data is Map<String, dynamic>) {
        return CountryDetails.fromJson(resp.data);
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Country not found');
      }
      throw Exception('Failed to load country details: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load country details: $e');
    }
  }
  }