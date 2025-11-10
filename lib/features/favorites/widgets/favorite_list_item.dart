import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../data/models/favorite_country.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoriteCountry fav;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const FavoriteListItem({
    super.key,
    required this.fav,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: fav.flag,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: Colors.grey[300]),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.flag, size: 20),
              ),
            ),
          ),
        ),
        title: Text(
          fav.name,
          style: isDark ? AppTextStyles.darkListTitle(context) : AppTextStyles.listTitle,
        ),
        subtitle: Text(
          fav.capital ?? 'No capital',
          style: isDark ? AppTextStyles.darkListSubtitle(context) : AppTextStyles.listSubtitle,
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: isDark ? AppColors.darkFavorite : AppColors.favorite),
          onPressed: onToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}