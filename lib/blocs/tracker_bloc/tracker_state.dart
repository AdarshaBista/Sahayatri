part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {
  const TrackerLoading();
}

class TrackerLocationError extends TrackerState {
  const TrackerLocationError();
}

class TrackerUpdating extends TrackerState {
  final TrackerData data;

  const TrackerUpdating({
    @required this.data,
  }) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class TrackerError extends TrackerState {
  final String message;

  const TrackerError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
