// widgets/favorite_list_item.dart
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: fav.flag,
            width: 56,
            height: 36,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.grey[200]),
          ),
        ),
        title: Text(fav.name, style: AppTextStyles.listTitle),
        subtitle: Text(
          fav.capital ?? 'No capital',
          style: AppTextStyles.listSubtitle,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color: AppColors.favorite,
          ),
          onPressed: onToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}