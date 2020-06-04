part of 'tracker_bloc.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object> get props => [];
}

class TrackingStarted extends TrackerEvent {
  final Coord trailHeadCoord;

  const TrackingStarted({
    @required this.trailHeadCoord,
  }) : assert(trailHeadCoord != null);

  @override
  List<Object> get props => [trailHeadCoord];
}
