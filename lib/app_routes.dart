import 'package:flutter/material.dart';
import 'features/home/screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/detail/:cca2',
      builder: (context, state) {
        final cca2 = state.pathParameters['cca2']!;
        return CountryDetailScreen(cca2: cca2);
      },
    ),
  ],
);