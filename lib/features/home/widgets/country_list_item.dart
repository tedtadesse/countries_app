import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/utils/population_formatter.dart';
import '../../../data/models/country_summary.dart';

class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final bool isFavorite;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.isFavorite,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: _buildFlagImage(),
        title: Text(
          country.name,
          style: AppTextStyles.listTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          formatPopulation(country.population),
          style: AppTextStyles.listSubtitle,
        ),
        trailing: _buildFavoriteButton(),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFlagImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: country.flagPng,
        width: 56,
        height: 36,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: 56,
          height: 36,
          color: Colors.grey[200],
        ),
        errorWidget: (_, __, ___) => Container(
          width: 56,
          height: 36,
          color: Colors.grey[200],
          child: const Icon(Icons.flag, size: 20),
        ),
        memCacheHeight: 72, // Reduce cache size
        memCacheWidth: 112,
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? AppColors.favorite : null,
      ),
      onPressed: onToggle,
    );
  }
}