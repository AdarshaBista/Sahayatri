part of 'tracker_bloc.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class TrackingStarted extends TrackerEvent {
  final Destination destination;

  const TrackingStarted({
    @required this.destination,
  }) : assert(destination != null);

  @override
  List<Object> get props => [destination];
}

class TrackingUpdated extends TrackerEvent {
  final TrackerData data;

  const TrackingUpdated({
    @required this.data,
  }) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class TrackingStopped extends TrackerEvent {
  const TrackingStopped();
}
