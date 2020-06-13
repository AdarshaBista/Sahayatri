import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/database/dao.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  static const int kPrefsId = 0;
  final Dao<Prefs> prefsDao;

  PrefsBloc({
    @required this.prefsDao,
  }) : assert(prefsDao != null);

  @override
  PrefsState get initialState => PrefsState(
        prefs: prefsDao.fetch(kPrefsId, defaultValue: const Prefs()),
      );

  @override
  Stream<PrefsState> mapEventToState(PrefsEvent event) async* {
    if (event is MapLayerChanged) {
      final newPrefs = state.prefs.copyWith(mapStyle: event.mapStyle);
      prefsDao.store(kPrefsId, newPrefs);
      yield PrefsState(prefs: newPrefs);
    }

    if (event is ContactSaved) {
      final newPrefs = state.prefs.copyWith(contact: event.contact);
      prefsDao.store(kPrefsId, newPrefs);
      yield PrefsState(prefs: newPrefs);
    }
  }
}
