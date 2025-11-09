import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class LoadDetails extends DetailEvent {
  final String cca2;
  const LoadDetails(this.cca2);

  @override
  List<Object?> get props => [cca2];
}