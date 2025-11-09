import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/utils/population_formatter.dart';
import '../../../data/models/country_summary.dart';

class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CountryListItem({
    super.key,
    required this.country,
    required this.onTap,
    this.isFavorite = false,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: country.flag,
        width: 50,
        height: 35,
        fit: BoxFit.cover,
      ),
      title: Text(country.name),
      subtitle: Text('Population: ${formatPopulation(country.population)}'),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
        onPressed: onToggleFavorite,
      ),
      onTap: onTap,
    );
  }
}