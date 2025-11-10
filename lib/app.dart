import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/services/local_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'app_routes.dart';
import 'features/favorites/bloc/favorites_bloc.dart';
import 'features/favorites/bloc/favorites_event.dart';

class CountriesApp extends StatelessWidget {
  const CountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoritesBloc(sl<LocalStorageService>())..add(LoadFavorites()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Countries',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}