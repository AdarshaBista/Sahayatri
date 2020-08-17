part of 'destinations_cubit.dart';

abstract class DestinationsState extends Equatable {
  const DestinationsState();

  @override
  List<Object> get props => [];
}

class DestinationsLoading extends DestinationsState {
  const DestinationsLoading();
}

class DestinationsEmpty extends DestinationsState {
  const DestinationsEmpty();
}

class DestinationsLoaded extends DestinationsState {
  final List<Destination> destinations;

  const DestinationsLoaded({
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
