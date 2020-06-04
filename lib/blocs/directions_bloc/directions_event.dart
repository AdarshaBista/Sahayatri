part of 'directions_bloc.dart';

abstract class DirectionsEvent extends Equatable {
  const DirectionsEvent();

  @override
  List<Object> get props => [];
}

class DirectionsStarted extends DirectionsEvent {
  final Place trailHead;

  const DirectionsStarted({
    @required this.trailHead,
  }) : assert(trailHead != null);

  @override
  List<Object> get props => [trailHead];
}
