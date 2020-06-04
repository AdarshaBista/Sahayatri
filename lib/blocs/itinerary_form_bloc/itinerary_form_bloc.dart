import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

part 'itinerary_form_event.dart';
part 'itinerary_form_state.dart';

class ItineraryFormBloc extends Bloc<ItineraryFormEvent, ItineraryFormState> {
  final Itinerary itinerary;

  ItineraryFormBloc({
    @required this.itinerary,
  });

  @override
  ItineraryFormState get initialState => ItineraryFormState(
        name: itinerary?.name ?? '',
        days: itinerary?.days ?? '',
        nights: itinerary?.nights ?? '',
        checkpoints: itinerary?.checkpoints ?? [],
      );

  @override
  Stream<ItineraryFormState> mapEventToState(
    ItineraryFormEvent event,
  ) async* {
    if (event is NameChanged) {
      yield state.copyWith(name: event.name);
    }

    if (event is DaysChanged) {
      yield state.copyWith(days: event.days);
    }

    if (event is NightsChanged) {
      yield state.copyWith(nights: event.nights);
    }

    if (event is CheckpointAdded) {
      final checkpoints = state.checkpoints..add(event.checkpoint);
      yield state.copyWith(checkpoints: checkpoints);
    }

    if (event is CheckpointUpdated) {
      final checkpoints = state.checkpoints;
      final index = checkpoints.indexOf(event.prevCheckpoint);
      checkpoints.remove(event.prevCheckpoint);
      checkpoints.insert(index, event.newCheckpoint);
      yield state.copyWith(checkpoints: checkpoints);
    }

    if (event is CheckpointRemoved) {
      final checkpoints = state.checkpoints..remove(event.checkpoint);
      yield state.copyWith(checkpoints: checkpoints);
    }
  }
}
