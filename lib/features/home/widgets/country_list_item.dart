import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/utils/population_formatter.dart';
import '../../../data/models/country_summary.dart';

class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final bool isFavorite;
  final bool showPopulation;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.isFavorite,
    this.showPopulation = true,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? AppColors.darkCard : AppColors.card,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: showPopulation ? 8 : 16),
        leading: Hero(
          tag: 'flag-${country.cca2}',
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: country.flagPng,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: Colors.grey[300]),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.flag, size: 20),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          country.name,
          style: isDark ? AppTextStyles.darkListTitle(context) : AppTextStyles.listTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: showPopulation
            ? RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Population: ",
                style: isDark
                    ? AppTextStyles.darkListSubtitle(context)
                    : AppTextStyles.listSubtitle,
              ),
              TextSpan(
                text: formatPopulation(country.population),
                style: isDark
                    ? AppTextStyles.darkListSubtitle(context)
                    : AppTextStyles.listSubtitle,
              ),
            ],
          ),
        )
            : null,
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? (isDark ? AppColors.darkFavorite : AppColors.favorite)
                : null,
          ),
          onPressed: onToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}