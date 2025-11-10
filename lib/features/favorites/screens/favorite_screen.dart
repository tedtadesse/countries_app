import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../../../data/models/country_summary.dart';
import '../widgets/favorite_list_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritesView();
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      appBar: AppBar(title: Center(child: Center(child: const Text('Favorites')))),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (ctx, state) {
          if (state is FavoritesLoading) {
            return const _ShimmerList();
          }
          final favs = (state as FavoritesLoaded).favorites;
          if (favs.isEmpty) {
            return const Center(child: Text('No favorite countries yet.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: favs.length,
            itemBuilder: (_, i) {
              final f = favs[i];
              return FavoriteListItem(
                fav: f,
                onToggle: () {
                  final summary = CountrySummary(
                    name: f.name,
                    flagPng: f.flag,
                    population: 0,
                    cca2: f.cca2,
                  );
                  ctx.read<FavoritesBloc>().add(ToggleFavorite(summary));
                },
                onTap: () => context.push('/detail/${f.cca2}'),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (i) => i == 0 ? context.go('/home') : null,

        selectedItemColor: isDark ? Colors.white: AppColors.darkCard ,
        unselectedItemColor: isDark ? Colors.grey : Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder:
            (_, __) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: Container(width: 56, height: 36, color: isDark ? AppColors.darkCard : Colors.white),
            title: Container(height: 16, color: isDark ? AppColors.darkCard : Colors.white),
            subtitle: Container(height: 14, color: isDark ? AppColors.darkCard : Colors.white),
          ),
        ),
      ),
    );
  }
}
