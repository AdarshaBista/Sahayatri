import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

part 'itinerary_form_state.dart';

class ItineraryFormCubit extends Cubit<ItineraryFormState> {
  final Itinerary itinerary;

  ItineraryFormCubit({
    @required this.itinerary,
  }) : super(
          ItineraryFormState(
            name: itinerary?.name ?? '',
            days: itinerary?.days ?? '',
            nights: itinerary?.nights ?? '',
            checkpoints:
                itinerary == null ? [] : List<Checkpoint>.from(itinerary.checkpoints),
          ),
        );

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
    emit(state.copyWith(checkpoints: checkpoints));
  }

  void updateCheckpoint(Checkpoint prevCheckpoint, Checkpoint newCheckpoint) {
    final checkpoints = state.checkpoints;
    final index = checkpoints.indexOf(prevCheckpoint);
    checkpoints.remove(prevCheckpoint);
    checkpoints.insert(index, newCheckpoint);
    emit(state.copyWith(checkpoints: checkpoints));
  }

  void removeCheckpoint(Checkpoint checkpoint) {
    final checkpoints = state.checkpoints..remove(checkpoint);
    emit(state.copyWith(checkpoints: checkpoints));
  }
}
