import 'package:go_router/go_router.dart';

import 'features/favorites/screens/favorite_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/country_detail/screens/country_detail_screen.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (_, __) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/detail/:cca2',
      builder: (_, state) => CountryDetailScreen(
        cca2: state.pathParameters['cca2']!,
      ),
    ),
  ],
);