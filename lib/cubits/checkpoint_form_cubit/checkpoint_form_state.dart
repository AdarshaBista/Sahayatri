part of 'checkpoint_form_cubit.dart';

class CheckpointFormState extends Equatable {
  final Place place;
  final String description;
  final DateTime dateTime;

  Checkpoint get checkpoint => Checkpoint(
        place: place,
        description: description.trim(),
        dateTime: dateTime,
      );

  const CheckpointFormState({
    @required this.place,
    @required this.description,
    @required this.dateTime,
  }) : assert(description != null);

  CheckpointFormState copyWith({
    Place place,
    String description,
    DateTime dateTime,
  }) {
    return CheckpointFormState(
      place: place ?? this.place,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object> get props => [place, description, dateTime];
}
