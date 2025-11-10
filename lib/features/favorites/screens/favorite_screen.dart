import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/local_storage_service.dart';
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
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Favorites'))),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (ctx, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
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

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}