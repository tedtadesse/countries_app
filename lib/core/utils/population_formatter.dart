import 'package:intl/intl.dart';

String formatPopulation(int pop) {
  final formatter = NumberFormat.compact();
  return 'Population: ${formatter.format(pop)}';
}