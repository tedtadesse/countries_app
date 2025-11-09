import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_countries_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCountriesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final favorites = (state as FavoritesLoaded).favorites;
        return Scaffold(
          appBar: AppBar(title: const Text('Favorites')),
          body: favorites.isEmpty
              ? const Center(child: Text('No favorites yet.'))
              : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final fav = favorites[index];
              return FavoriteListItem(
                favorite: fav,
                onTap: () => context.push('/detail/${fav.cca2}'),
                onToggle: () => context.read<FavoritesCountriesBloc>().add(ToggleFavoriteEvent(fav.cca2, /* pass summary if needed */ CountrySummary(/* mock */))),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) context.go('/home');
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            ],
          ),
        );
      },
    );
  }
}