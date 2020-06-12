part of 'directions_bloc.dart';

abstract class DirectionsEvent extends Equatable {
  const DirectionsEvent();

  @override
  List<Object> get props => [];
}

class DirectionsStarted extends DirectionsEvent {
  final Place trailHead;
  // final NavigationMode mode;

  const DirectionsStarted({
    @required this.trailHead,
    // @required this.mode,
  }) : assert(trailHead != null);
  // assert(mode != null);

  @override
  List<Object> get props => [trailHead];
}
