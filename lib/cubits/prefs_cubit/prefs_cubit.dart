import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/models/map_layers.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  final PrefsDao prefsDao;

  PrefsCubit({
    @required this.prefsDao,
  })  : assert(prefsDao != null),
        super(const PrefsState(isLoading: true));

  Prefs get prefs => state.prefs;

  Future<void> initPrefs() async {
    final prefs = await prefsDao.get();
    emit(PrefsState(prefs: prefs));
  }

  void saveMapStyle(String mapStyle) {
    final newPrefs = state.prefs.copyWith(mapStyle: mapStyle);
    _updatePrefs(newPrefs);
  }

  void saveContact(String contact) {
    final newPrefs = state.prefs.copyWith(contact: contact);
    _updatePrefs(newPrefs);
  }

  void saveDeviceName(String name) {
    final newPrefs = state.prefs.copyWith(deviceName: name);
    _updatePrefs(newPrefs);
  }

  void saveTheme(String theme) {
    final newPrefs = state.prefs.copyWith(theme: theme);
    _updatePrefs(newPrefs);
  }

  void saveMapLayers(MapLayers mapLayers) {
    final newPrefs = state.prefs.copyWith(mapLayers: mapLayers);
    _updatePrefs(newPrefs);
  }

  void _updatePrefs(Prefs newPrefs) {
    emit(PrefsState(prefs: newPrefs));
    prefsDao.upsert(newPrefs);
  }
}
