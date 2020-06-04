part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {}

class TrackerLocationError extends TrackerState {}

class TrackerSuccess extends TrackerState {
  final UserLocation initialLocation;
  final Stream<UserLocation> userLocationStream;

  const TrackerSuccess({
    @required this.initialLocation,
    @required this.userLocationStream,
  })  : assert(initialLocation != null),
        assert(userLocationStream != null);

  @override
  List<Object> get props => [userLocationStream];
}

class TrackerError extends TrackerState {
  final String message;

  const TrackerError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
