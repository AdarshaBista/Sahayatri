import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/itinerary.dart';

part 'itinerary_form_state.dart';

class ItineraryFormCubit extends Cubit<ItineraryFormState> {
  final Itinerary? itinerary;

  ItineraryFormCubit({
    required this.itinerary,
  }) : super(
          ItineraryFormState(
            name: itinerary?.name ?? '',
            days: itinerary?.days ?? '',
            nights: itinerary?.nights ?? '',
            checkpoints: itinerary == null ? [] : List<Checkpoint>.from(itinerary.checkpoints),
          ),
        );

  bool get isDirty => state.isDirty(itinerary);

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeDays(String days) {
    emit(state.copyWith(days: days));
  }

  void changeNights(String nights) {
    emit(state.copyWith(nights: nights));
  }

  void addCheckpoint(Checkpoint checkpoint) {
    final checkpoints = state.checkpoints..add(checkpoint);
    _sortCheckpoints(checkpoints);
    emit(state.copyWith(checkpoints: checkpoints));
  }

  void updateCheckpoint(Checkpoint prevCheckpoint, Checkpoint newCheckpoint) {
    final checkpoints = state.checkpoints;
    final index = checkpoints.indexOf(prevCheckpoint);
    checkpoints.remove(prevCheckpoint);
    checkpoints.insert(index, newCheckpoint);
    _sortCheckpoints(checkpoints);
    emit(state.copyWith(checkpoints: checkpoints));
  }

  void removeCheckpoint(Checkpoint checkpoint) {
    final checkpoints = state.checkpoints..remove(checkpoint);
    _sortCheckpoints(checkpoints);
    emit(state.copyWith(checkpoints: checkpoints));
  }

  void _sortCheckpoints(List<Checkpoint> checkpoints) {
    final bool isSortable = checkpoints.every((c) => c.dateTime != null);
    if (!isSortable) return;
    checkpoints.sort((c1, c2) => c1.dateTime!.compareTo(c2.dateTime!));
  }
}
