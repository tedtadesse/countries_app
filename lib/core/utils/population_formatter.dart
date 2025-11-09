import 'package:intl/intl.dart';

String formatPopulation(int population) {
  if (population >= 1000000000) {
    return '${(population / 1000000000).toStringAsFixed(1)}B';
  } else if (population >= 1000000) {
    return '${(population / 1000000).toStringAsFixed(1)}M';
  } else {
    return '${(population / 1000).toStringAsFixed(1)}K';
  }
}