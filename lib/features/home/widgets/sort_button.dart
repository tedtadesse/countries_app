import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

enum SortOrder {
  nameAsc,
  nameDesc,
  populationDesc,
  populationAsc,
}

class SortButton extends StatelessWidget {
  final SortOrder sortOrder;

  const SortButton({
    super.key,
    required this.sortOrder,
  });

  String _getSortLabel(SortOrder order) {
    switch (order) {
      case SortOrder.nameAsc:
        return 'A-Z';
      case SortOrder.nameDesc:
        return 'Z-A';
      case SortOrder.populationDesc:
        return 'Population ↓';
      case SortOrder.populationAsc:
        return 'Population ↑';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return PopupMenuButton<SortOrder>(
      color: isDark ? AppColors.darkCard : Colors.white,
      icon: Stack(
        children: [
          const Icon(Icons.sort),
          if (sortOrder != SortOrder.nameAsc)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      initialValue: sortOrder,
      onSelected: (order) {
        context.read<HomeBloc>().add(SortCountries(order));
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: SortOrder.nameAsc,
          child: Row(
            children: [
              const Icon(Icons.sort_by_alpha, size: 20),
              const SizedBox(width: 12),
              const Text('Name A-Z'),
            ],
          ),
        ),
        PopupMenuItem(
          value: SortOrder.nameDesc,
          child: Row(
            children: [
              const Icon(Icons.sort_by_alpha, size: 20),
              const SizedBox(width: 12),
              const Text('Name Z-A'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: SortOrder.populationDesc,
          child: Row(
            children: [
              Icon(Icons.people, size: 20),
              SizedBox(width: 12),
              Text('Population (High to Low)'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: SortOrder.populationAsc,
          child: Row(
            children: [
              Icon(Icons.people, size: 20),
              SizedBox(width: 12),
              Text('Population (Low to High)'),
            ],
          ),
        ),
      ],
    );
  }
}