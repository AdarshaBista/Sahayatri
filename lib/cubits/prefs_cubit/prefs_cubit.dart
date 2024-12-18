import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/map_layers.dart';
import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

import 'package:sahayatri/locator.dart';

part 'prefs_state.dart';

class PrefsCubit extends Cubit<PrefsState> {
  PrefsDao? prefsDao;

  PrefsCubit() : super(const PrefsState(isLoading: true));

  Prefs get prefs => state.prefs;

  Future<void> init() async {
    prefsDao = locator();
    final prefs = await prefsDao?.get() ?? const Prefs();
    emit(PrefsState(prefs: prefs));
  }

  void reset() {
    prefsDao = null;
    emit(const PrefsState());
  }

  void saveMapStyle(String mapStyle) {
    final newPrefs = state.prefs.copyWith(mapStyle: mapStyle);
    _update(newPrefs);
  }

  void saveContact(String contact) {
    final newPrefs = state.prefs.copyWith(contact: contact);
    _update(newPrefs);
  }

  void saveDeviceName(String name) {
    final newPrefs = state.prefs.copyWith(deviceName: name);
    _update(newPrefs);
  }

  void saveTheme(String theme) {
    final newPrefs = state.prefs.copyWith(theme: theme);
    _update(newPrefs);
  }

  void saveMapLayers(MapLayers mapLayers) {
    final newPrefs = state.prefs.copyWith(mapLayers: mapLayers);
    _update(newPrefs);
  }

  void saveGpsAccuracy(String gpsAccuracy) {
    final newPrefs = state.prefs.copyWith(gpsAccuracy: gpsAccuracy);
    _update(newPrefs);
  }

  void _update(Prefs newPrefs) {
    emit(PrefsState(prefs: newPrefs));
    prefsDao?.upsert(newPrefs);
  }
}
