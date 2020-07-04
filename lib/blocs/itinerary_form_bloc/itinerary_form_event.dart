part of 'itinerary_form_bloc.dart';

abstract class ItineraryFormEvent extends Equatable {
  const ItineraryFormEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ItineraryFormEvent {
  final String name;

  const NameChanged({
    @required this.name,
  }) : assert(name != null);

  @override
  List<Object> get props => [name];
}

class DaysChanged extends ItineraryFormEvent {
  final String days;

  const DaysChanged({
    @required this.days,
  }) : assert(days != null);

  @override
  List<Object> get props => [days];
}

class NightsChanged extends ItineraryFormEvent {
  final String nights;

  const NightsChanged({
    @required this.nights,
  }) : assert(nights != null);

  @override
  List<Object> get props => [nights];
}

class CheckpointAdded extends ItineraryFormEvent {
  final Checkpoint checkpoint;

  const CheckpointAdded({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  List<Object> get props => [checkpoint];
}

class CheckpointUpdated extends ItineraryFormEvent {
  final Checkpoint newCheckpoint;
  final Checkpoint prevCheckpoint;

  const CheckpointUpdated({
    @required this.newCheckpoint,
    @required this.prevCheckpoint,
  })  : assert(newCheckpoint != null),
        assert(prevCheckpoint != null);

  @override
  List<Object> get props => [newCheckpoint, prevCheckpoint];
}

class CheckpointRemoved extends ItineraryFormEvent {
  final Checkpoint checkpoint;

  const CheckpointRemoved({
    @required this.checkpoint,
  }) : assert(checkpoint != null);

  @override
  List<Object> get props => [checkpoint];
}
