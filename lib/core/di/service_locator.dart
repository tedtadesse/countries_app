import 'package:get_it/get_it.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
}