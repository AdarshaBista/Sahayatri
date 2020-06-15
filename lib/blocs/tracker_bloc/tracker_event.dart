part of 'tracker_bloc.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class TrackingStarted extends TrackerEvent {
  final List<Coord> route;
  final Coord trailHeadCoord;

  const TrackingStarted({
    @required this.route,
    @required this.trailHeadCoord,
  })  : assert(route != null),
        assert(trailHeadCoord != null);

  @override
  List<Object> get props => [route, trailHeadCoord];
}
