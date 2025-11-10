import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/api_service.dart';
import '../../../core/theme/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
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
            return const _ShimmerDetail();
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
            return _buildDetailContent(d, context);
          }

          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }


  Widget _buildDetailContent(CountryDetails d, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: 'flag-${d.cca2}',
            child: CachedNetworkImage(
              imageUrl: d.flag,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              fit: BoxFit.cover,
              placeholder: (_, __) => _shimmerFlagPlaceholder(),
              errorWidget: (_, __, ___) => const Icon(Icons.flag, size: 80),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Statistics",
                  style: isDark
                      ? AppTextStyles.darkSectionTitle(context)
                      : AppTextStyles.sectionTitle,
                ),
                const SizedBox(height: 20),
                _StatRow("Area", '${d.area?.toStringAsFixed(0) ?? 'N/A'} sq km', isDark),
                _StatRow("Population", formatPopulation(d.population) ?? 'N/A', isDark),
                _StatRow("Region", d.region ?? 'N/A', isDark),
                _StatRow("Sub Region", d.subregion ?? 'N/A', isDark),

                if (d.timezones?.isNotEmpty == true) ...[
                  const SizedBox(height: 32),
                  Text(
                    "Timezone",
                    style: isDark
                        ? AppTextStyles.darkSectionTitle(context)
                        : AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: d.timezones!
                        .map((tz) => Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: Text(tz,
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary)),
                      backgroundColor:
                      isDark ? const Color(0xFF2D2D2D) : Colors.white,
                      side: BorderSide(
                          color: isDark
                              ? const Color(0xFF424242)
                              : const Color(0xFFE8E8E8)),
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
  final bool isDark;
  const _StatRow(this.label, this.value, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isDark
                  ? AppTextStyles.darkStatLabel(context)
                  : AppTextStyles.statLabel),
          Text(value,
              style: isDark
                  ? AppTextStyles.darkStatValue(context)
                  : AppTextStyles.statValue),
        ],
      ),
    );
  }
}


class _ShimmerDetail extends StatelessWidget {
  const _ShimmerDetail();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: 140, color: Colors.white),
                  const SizedBox(height: 12),

                  ...List.generate(4, (_) => const _ShimmerStatRow()),
                  const SizedBox(height: 24),

                  Container(height: 20, width: 100, color: Colors.white),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      6,
                          (_) => Chip(
                        label: Container(height: 14, width: 50, color: Colors.white),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _ShimmerStatRow extends StatelessWidget {
  const _ShimmerStatRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 14, width: 80, color: Colors.white),
          Container(height: 14, width: 120, color: Colors.white),
        ],
      ),
    );
  }
}
Widget _shimmerFlagPlaceholder() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(color: Colors.white),
  );
}
