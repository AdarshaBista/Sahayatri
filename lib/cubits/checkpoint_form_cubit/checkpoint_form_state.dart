part of 'checkpoint_form_cubit.dart';

class CheckpointFormState extends Equatable {
  final Place? place;
  final DateTime? dateTime;
  final String description;
  final bool notifyContact;

  Checkpoint get checkpoint => Checkpoint(
        place: place!,
        description: description.trim(),
        dateTime: dateTime,
        notifyContact: notifyContact,
      );

  const CheckpointFormState({
    required this.place,
    required this.description,
    required this.dateTime,
    required this.notifyContact,
  });

  CheckpointFormState copyWith({
    Place? place,
    String? description,
    DateTime? dateTime,
    bool? notifyContact,
  }) {
    return CheckpointFormState(
      place: place ?? this.place,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      notifyContact: notifyContact ?? this.notifyContact,
    );
  }

  bool isDirty(Checkpoint? initial) {
    if (initial == null) {
      return place != null || description.isNotEmpty || dateTime != null || notifyContact == false;
    }

    return initial.place != place ||
        initial.description != description ||
        initial.notifyContact != notifyContact ||
        initial.dateTime != dateTime;
  }

  @override
  List<Object?> get props => [place, description, dateTime, notifyContact];
}
