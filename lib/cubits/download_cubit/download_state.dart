part of 'download_cubit.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadInitial extends DownloadState {
  const DownloadInitial();
}

class DownloadInProgress extends DownloadState {
  final String message;

  const DownloadInProgress({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class DownloadCompleted extends DownloadState {
  const DownloadCompleted();
}

class DownloadError extends DownloadState {
  final String message;

  const DownloadError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
