import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.sort),
      onSelected: (v) {
        // sorting is done in the BLoC – we just fire events
        if (v == 'name') {
          // implement in BLoC if you want
        } else if (v == 'population') {}
      },
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'name', child: Text('Name')),
        const PopupMenuItem(value: 'population', child: Text('Population')),
      ],
    );
  }
}