part of 'downloaded_destinations_cubit.dart';

abstract class DownloadedDestinationsState extends Equatable {
  const DownloadedDestinationsState();

  @override
  List<Object> get props => [];
}

class DownloadedDestinationsLoading extends DownloadedDestinationsState {
  const DownloadedDestinationsLoading();
}

class DownloadedDestinationsEmpty extends DownloadedDestinationsState {
  const DownloadedDestinationsEmpty();
}

class DownloadedDestinationsLoaded extends DownloadedDestinationsState {
  final List<Destination> destinations;

  const DownloadedDestinationsLoaded({
    @required this.destinations,
  }) : assert(destinations != null);

  @override
  List<Object> get props => [destinations];
}

class DownloadedDestinationsError extends DownloadedDestinationsState {
  final String message;

  const DownloadedDestinationsError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
