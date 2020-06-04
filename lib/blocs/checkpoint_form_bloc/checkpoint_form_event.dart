part of 'checkpoint_form_bloc.dart';

abstract class CheckpointFormEvent extends Equatable {
  const CheckpointFormEvent();
}

class PlaceChanged extends CheckpointFormEvent {
  final Place place;

  PlaceChanged({
    @required this.place,
  }) : assert(place != null);

  @override
  List<Object> get props => [place];
}

class DescriptionChanged extends CheckpointFormEvent {
  final String description;

  DescriptionChanged({
    @required this.description,
  }) : assert(description != null);

  @override
  List<Object> get props => [description];
}

class DateTimeChanged extends CheckpointFormEvent {
  final DateTime dateTime;

  DateTimeChanged({
    @required this.dateTime,
  }) : assert(dateTime != null);

  @override
  List<Object> get props => [dateTime];
}
