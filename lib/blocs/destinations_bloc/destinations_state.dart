part of 'destinations_bloc.dart';

abstract class DestinationsState extends Equatable {
  const DestinationsState();

  @override
  List<Object> get props => [];
}

class DestinationsLoading extends DestinationsState {}

class DestinationsEmpty extends DestinationsState {}

class DestinationsSuccess extends DestinationsState {
  final List<Destination> destinations;

  const DestinationsSuccess({
    @required this.destinations,
  }) : assert(destinations != null);

  @override
  List<Object> get props => [destinations];
}

class DestinationsError extends DestinationsState {
  final String message;

  const DestinationsError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
