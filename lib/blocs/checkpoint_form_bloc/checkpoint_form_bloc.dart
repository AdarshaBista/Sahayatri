import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

part 'checkpoint_form_event.dart';
part 'checkpoint_form_state.dart';

class CheckpointFormBloc
    extends Bloc<CheckpointFormEvent, CheckpointFormState> {
  final Checkpoint checkpoint;

  CheckpointFormBloc({
    @required this.checkpoint,
  });

  @override
  CheckpointFormState get initialState => CheckpointFormState(
        place: checkpoint?.place ?? null,
        description: checkpoint?.description ?? '',
        dateTime: checkpoint?.dateTime ?? null,
      );

  @override
  Stream<CheckpointFormState> mapEventToState(
    CheckpointFormEvent event,
  ) async* {
    if (event is PlaceChanged) {
      yield state.copyWith(place: event.place);
    }

    if (event is DescriptionChanged) {
      yield state.copyWith(description: event.description);
    }

    if (event is DateTimeChanged) {
      yield state.copyWith(dateTime: event.dateTime);
    }
  }
}
