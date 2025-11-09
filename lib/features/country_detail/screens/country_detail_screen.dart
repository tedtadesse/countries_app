import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_detail_bloc.dart';
import '../bloc/country_detail_event.dart';
import '../bloc/country_detail_state.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/population_formatter.dart';

class CountryDetailScreen extends StatelessWidget {
  final String cca2;
  const CountryDetailScreen({super.key, required this.cca2});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryDetailBloc(apiService: ApiService())..add(LoadCountryDetails(cca2)),
      child: BlocBuilder<CountryDetailBloc, CountryDetailState>(
        builder: (context, state) {
          if (state is CountryDetailLoading) {
            return Scaffold(
              appBar: AppBar(title: Text('Loading...')),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CountryDetailError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Column(
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => context.read<CountryDetailBloc>().add(LoadCountryDetails(cca2)),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          final details = (state as CountryDetailLoaded).details;
          return Scaffold(
            appBar: AppBar(title: Text(details.name)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: 'flag-$cca2',
                    child: Image.network(
                      details.flag,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Key Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        _buildStatRow('Area', '${details.area?.toStringAsFixed(0) ?? 'N/A'} km²'),
                        _buildStatRow('Population', formatPopulation(details.population)),
                        _buildStatRow('Region', details.region),
                        _buildStatRow('Sub Region', details.subregion ?? 'N/A'),
                        const SizedBox(height: 16),
                        const Text('Timezone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ...details.timezones?.map((tz) => Text(tz)) ?? [const Text('N/A')],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}