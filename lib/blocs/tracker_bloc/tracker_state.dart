part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {}

class TrackerLocationError extends TrackerState {}

class TrackerSuccess extends TrackerState {
  final TrackerData data;

  const TrackerSuccess({
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
