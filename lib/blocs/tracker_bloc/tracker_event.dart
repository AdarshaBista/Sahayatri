part of 'tracker_bloc.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class TrackingStarted extends TrackerEvent {
  final List<Coord> route;

  const TrackingStarted({
    @required this.route,
  }) : assert(route != null);

  @override
  List<Object> get props => [route];
}
