import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  final PrefsDao prefsDao;

  PrefsCubit({
    @required this.prefsDao,
  })  : assert(prefsDao != null),
        super(const PrefsLoading());

  Prefs get prefs => (state as PrefsLoaded).prefs;

  Future<void> initPrefs() async {
    final prefs = await prefsDao.get();
    emit(PrefsLoaded(prefs: prefs));
  }

  void saveMapLayer(String mapStyle) {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(mapStyle: mapStyle);
    _updatePrefs(newPrefs);
  }

  void saveContact(String contact) {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(contact: contact);
    _updatePrefs(newPrefs);
  }

  void saveDeviceName(String name) {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(deviceName: name);
    _updatePrefs(newPrefs);
  }

  void saveTheme(String theme) {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(theme: theme);
    _updatePrefs(newPrefs);
  }

  void _updatePrefs(Prefs newPrefs) {
    emit(PrefsLoaded(prefs: newPrefs));
    prefsDao.upsert(newPrefs);
  }
}
