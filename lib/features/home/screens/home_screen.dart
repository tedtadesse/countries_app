import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/country_summary.dart';
import '../../favorites/bloc/favorites_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/country_list_item.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/bloc/favorites_event.dart';
import '../widgets/sort_button.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      appBar: AppBar(title: const Center(child: Text('Countries'))),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSearchField(context)),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SortButton(
                      sortOrder:
                          state is HomeLoaded
                              ? state.sortOrder
                              : SortOrder.nameAsc,
                    ),
                  );
                },
              ),
            ],
          ),

          Expanded(child: _buildCountryList(context)),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, String>(
      selector: (state) => state is HomeLoaded ? state.searchQuery : '',
      builder: (context, searchQuery) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            onChanged: (q) => context.read<HomeBloc>().add(SearchCountries(q)),
            controller: TextEditingController(text: searchQuery),
            decoration: InputDecoration(
              hintText: 'Search for a country',
              hintStyle: TextStyle(color: Color(0xFF6B7582)),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: const Icon(Icons.search, color: Color(0xFF6B7582)),
              ),

              suffixIcon: searchQuery.isNotEmpty
                  ? Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.clear, size: 16),
                    onPressed: () {
                      context.read<HomeBloc>().add(ClearSearch());
                    },
                  ),
                ),
              )
                  : null,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountryList(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const _ShimmerList();
        if (state is HomeError) return _buildErrorState(context, state);

        final loaded = state as HomeLoaded;
        final countries = loaded.filtered;
        final searchQuery = loaded.searchQuery;

        if (countries.isEmpty) {
          return const Center(child: Text('No countries found.'));
        }

        return RefreshIndicator(
          onRefresh: () async => context.read<HomeBloc>().add(LoadCountries()),
          child: _CountryListView(
            countries: countries,
            searchQuery: searchQuery,
          ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (i) => i == 1 ? context.go('/favorites') : null,

      selectedItemColor: isDark ? Colors.white : AppColors.darkCard ,
      unselectedItemColor: isDark ? Colors.grey : Colors.grey[600],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
      ],
    );
  }
}

class _CountryListView extends StatelessWidget {
  final List<CountrySummary> countries;
  final String searchQuery;

  const _CountryListView({
    required this.countries,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: countries.length,
      itemBuilder: (_, i) {
        final country = countries[i];
        return _CountryListItem(
          country: country,
          searchQuery: searchQuery,
        );
      },
    );
  }
}
class _CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final String searchQuery;

  const _CountryListItem({
    required this.country,
    this.searchQuery = '',
  });

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
          showPopulation: searchQuery.isEmpty,
            onToggle: () async {
              final bloc = context.read<FavoritesBloc>();
              final currentState = bloc.state;
              final alreadyFavorite = currentState is FavoritesLoaded &&
                  currentState.favorites.any((f) => f.cca2 == country.cca2);

              if (!alreadyFavorite) {
                final details = await sl<ApiService>().getCountryDetails(country.cca2);
                bloc.add(ToggleFavorite(country, details.capital));
              } else {
                bloc.add(ToggleFavorite(country));
              }
            },
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
