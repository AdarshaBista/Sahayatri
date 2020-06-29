part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {}

class TrackerLocationError extends TrackerState {}

class TrackerSuccess extends TrackerState {
  final Place nextStop;
  final UserLocation userLocation;

  const TrackerSuccess({
    @required this.nextStop,
    @required this.userLocation,
  }) : assert(userLocation != null);

  @override
  List<Object> get props => [nextStop, userLocation];
}

class TrackerError extends TrackerState {
  final String message;

  const TrackerError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
