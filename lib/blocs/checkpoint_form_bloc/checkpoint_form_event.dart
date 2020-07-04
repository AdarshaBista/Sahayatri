part of 'checkpoint_form_bloc.dart';

abstract class CheckpointFormEvent extends Equatable {
  const CheckpointFormEvent();

  @override
  List<Object> get props => [];
}

class PlaceChanged extends CheckpointFormEvent {
  final Place place;

  const PlaceChanged({
    @required this.place,
  }) : assert(place != null);

  @override
  List<Object> get props => [place];
}

class DescriptionChanged extends CheckpointFormEvent {
  final String description;

  const DescriptionChanged({
    @required this.description,
  }) : assert(description != null);

  @override
  List<Object> get props => [description];
}

class DateTimeChanged extends CheckpointFormEvent {
  final DateTime dateTime;

  const DateTimeChanged({
    @required this.dateTime,
  }) : assert(dateTime != null);

  @override
  List<Object> get props => [dateTime];
}
