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
  final bool isSearching;
  final List<Destination> destinations;

  const DestinationsLoaded({
    this.isSearching = false,
    required this.destinations,
  });

  @override
  List<Object> get props => [isSearching, destinations];
}

class DestinationsError extends DestinationsState {
  final String message;

  const DestinationsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
