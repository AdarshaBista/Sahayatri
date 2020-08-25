part of 'downloaded_destinations_cubit.dart';

abstract class DownloadedDestinationsState {
  const DownloadedDestinationsState();
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
}

class DownloadedDestinationsError extends DownloadedDestinationsState {
  final String message;

  const DownloadedDestinationsError({
    @required this.message,
  }) : assert(message != null);
}

class DownloadedDestinationsMessage extends DownloadedDestinationsState {
  final String message;

  const DownloadedDestinationsMessage({
    @required this.message,
  }) : assert(message != null);
}
