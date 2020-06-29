part of 'tracker_bloc.dart';

abstract class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object> get props => [];
}

class TrackerLoading extends TrackerState {}

class TrackerLocationError extends TrackerState {}

class TrackerSuccess extends TrackerState {
  final int userIndex;
  final Duration eta;
  final Place nextStop;
  final double distanceWalked;
  final double distanceRemaining;
  final UserLocation userLocation;

  const TrackerSuccess({
    @required this.userIndex,
    @required this.eta,
    @required this.nextStop,
    @required this.distanceWalked,
    @required this.distanceRemaining,
    @required this.userLocation,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(distanceWalked != null),
        assert(distanceRemaining != null);

  @override
  List<Object> get props => [
        userIndex,
        eta,
        nextStop,
        userLocation,
        distanceWalked,
        distanceRemaining,
      ];
}

class TrackerError extends TrackerState {
  final String message;

  const TrackerError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
