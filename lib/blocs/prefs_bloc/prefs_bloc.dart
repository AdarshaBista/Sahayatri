import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  @override
  PrefsState get initialState => const PrefsState(prefs: Prefs());

  @override
  Stream<PrefsState> mapEventToState(PrefsEvent event) async* {
    if (event is MapLayerChanged) {
      final newPrefs = state.prefs.copyWith(mapStyle: event.mapStyle);
      yield PrefsState(prefs: newPrefs);
    }

    if (event is ContactSaved) {
      final newPrefs = state.prefs.copyWith(contact: event.contact);
      yield PrefsState(prefs: newPrefs);
    }
  }
}
