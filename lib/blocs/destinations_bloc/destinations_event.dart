part of 'destinations_bloc.dart';

abstract class DestinationsEvent extends Equatable {
  const DestinationsEvent();

  @override
  List<Object> get props => [];
}

class DestinationsFetched extends DestinationsEvent {}

class DestinationsSearched extends DestinationsEvent {
  final String query;

  const DestinationsSearched({
    @required this.query,
  }) : assert(query != null);

  @override
  List<Object> get props => [query];
}
