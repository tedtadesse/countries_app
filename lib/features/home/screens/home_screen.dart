import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/country_summary.dart';
import '../../favorites/bloc/favorites_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/country_list_item.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/bloc/favorites_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(sl<ApiService>()),
           child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: Column(
        children: [
          _buildSearchField(context),
          Expanded(child: _buildCountryList(context)),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: (q) => context.read<HomeBloc>().add(SearchCountries(q)),
        decoration: const InputDecoration(
          hintText: 'Search for a country',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildCountryList(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const _ShimmerList();
        if (state is HomeError) return _buildErrorState(context, state);

        final loaded = state as HomeLoaded;
        final countries = loaded.filtered;

        if (countries.isEmpty) {
          return const Center(child: Text('No countries found.'));
        }

        return RefreshIndicator(
          onRefresh: () async => context.read<HomeBloc>().add(LoadCountries()),
          child: _CountryListView(countries: countries),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, HomeError state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(state.message),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context.read<HomeBloc>().add(LoadCountries()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (i) => i == 1 ? context.go('/favorites') : null,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
      ],
    );
  }
}

// Separate widget to optimize rebuilds
class _CountryListView extends StatelessWidget {
  final List<CountrySummary> countries;

  const _CountryListView({required this.countries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: countries.length,
      itemBuilder: (_, i) {
        final country = countries[i];
        return _CountryListItem(country: country);
      },
    );
  }
}

class _CountryListItem extends StatelessWidget {
  final CountrySummary country;

  const _CountryListItem({required this.country});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesBloc, FavoritesState, bool>(
      selector: (state) {
        return state is FavoritesLoaded &&
            state.favorites.any((f) => f.cca2 == country.cca2);
      },
      builder: (context, isFavorite) {
        return CountryListItem(
          country: country,
          isFavorite: isFavorite,
          onToggle: () => context.read<FavoritesBloc>().add(ToggleFavorite(country)),
          onTap: () => context.push('/detail/${country.cca2}'),
        );
      },
    );
  }
}
class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, __) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: Container(width: 56, height: 36, color: Colors.white),
            title: Container(height: 16, color: Colors.white),
            subtitle: Container(height: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}