import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

part 'checkpoint_form_state.dart';

class CheckpointFormCubit extends Cubit<CheckpointFormState> {
  final Checkpoint? checkpoint;

  CheckpointFormCubit({
    required this.checkpoint,
  }) : super(
          CheckpointFormState(
            place: checkpoint?.place,
            description: checkpoint?.description ?? '',
            notifyContact: checkpoint?.notifyContact ?? true,
            dateTime: checkpoint == null
                ? null
                : checkpoint.isTemplate
                    ? null
                    : checkpoint.dateTime,
          ),
        );

  bool get isDirty => state.isDirty(checkpoint);

  void changePlace(Place place) {
    emit(state.copyWith(place: place));
  }

  void changeDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void changeDateTime(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));
  }

  void toggleNotifyContact(bool notifyContact) {
    emit(state.copyWith(notifyContact: notifyContact));
  }
}
