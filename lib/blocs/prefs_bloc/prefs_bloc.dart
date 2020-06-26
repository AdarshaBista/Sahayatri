import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/core/database/prefs_dao.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  final PrefsDao prefsDao;

  PrefsBloc({
    @required this.prefsDao,
  }) : assert(prefsDao != null);

  @override
  PrefsState get initialState => PrefsLoading();

  @override
  Stream<PrefsState> mapEventToState(PrefsEvent event) async* {
    if (event is PrefsInitialized) {
      final prefs = await prefsDao.get();
      yield PrefsLoaded(prefs: prefs);
    }

    if (event is MapLayerChanged) {
      final newPrefs = (state as PrefsLoaded).prefs.copyWith(mapStyle: event.mapStyle);
      prefsDao.upsert(newPrefs);
      yield PrefsLoaded(prefs: newPrefs);
    }

    if (event is ContactSaved) {
      final newPrefs = (state as PrefsLoaded).prefs.copyWith(contact: event.contact);
      prefsDao.upsert(newPrefs);
      yield PrefsLoaded(prefs: newPrefs);
    }
  }
}
