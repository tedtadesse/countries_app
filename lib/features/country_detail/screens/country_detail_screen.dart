import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/utils/population_formatter.dart';
import '../../../data/models/country_details.dart';
import '../bloc/country_detail_bloc.dart';
import '../bloc/country_detail_event.dart';
import '../bloc/country_detail_state.dart';

class CountryDetailScreen extends StatelessWidget {
  final String cca2;
  const CountryDetailScreen({super.key, required this.cca2});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryDetailBloc(sl<ApiService>())..add(LoadDetail(cca2)),
      child: const DetailView(),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CountryDetailBloc, CountryDetailState>(
          builder: (context, state) {
            if (state is DetailLoaded) {
              return Text(state.details.name);
            }
            return const Text('Country Details');
          },
        ),
      ),
      body: BlocBuilder<CountryDetailBloc, CountryDetailState>(
        builder: (ctx, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DetailError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final cca2 = ctx.read<CountryDetailBloc>().cca2;
                      if (cca2 != null) {
                        ctx.read<CountryDetailBloc>().add(LoadDetail(cca2));
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is DetailLoaded) {
            final d = state.details;
            return _buildDetailContent(d);
          }

          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }

  Widget _buildDetailContent(CountryDetails d) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'flag-${d.cca2}',
            child: CachedNetworkImage(
              imageUrl: d.flag,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 220,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 220,
                color: Colors.grey[200],
                child: const Icon(Icons.flag, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Key Statistics', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 12),
                _StatRow('Capital', d.capital ?? 'N/A'),
                _StatRow('Area', '${d.area?.toStringAsFixed(0) ?? 'N/A'} km²'),
                _StatRow('Population', formatPopulation(d.population)),
                _StatRow('Region', d.region),
                _StatRow('Sub Region', d.subregion ?? 'N/A'),

                if (d.timezones?.isNotEmpty == true) ...[
                  const SizedBox(height: 24),
                  const Text('Timezones', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: d.timezones!
                        .map((tz) => Chip(
                      label: Text(tz),
                      backgroundColor: Colors.grey[100],
                    ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.statLabel),
          Text(value, style: AppTextStyles.statValue),
        ],
      ),
    );
  }
}
