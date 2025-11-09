import 'package:equatable/equatable.dart';
import '../../../core/models/country_details.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailLoading extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailLoaded extends DetailState {
  final CountryDetails details;
  const DetailLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class DetailError extends DetailState {
  final String message;
  const DetailError(this.message);

  @override
  List<Object?> get props => [message];
}