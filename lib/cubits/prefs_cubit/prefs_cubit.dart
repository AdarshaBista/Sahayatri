import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';

part 'prefs_state.dart';

class PrefsBloc extends Cubit<PrefsState> {
  final PrefsDao prefsDao;

  PrefsBloc({
    @required this.prefsDao,
  })  : assert(prefsDao != null),
        super(const PrefsLoading());

  Future<void> initPrefs() async {
    final prefs = await prefsDao.get();
    emit(PrefsLoaded(prefs: prefs));
  }

  Future<void> changeMapLayer(String mapStyle) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(mapStyle: mapStyle);
    prefsDao.upsert(newPrefs);
    emit(PrefsLoaded(prefs: newPrefs));
  }

  Future<void> saveContact(String contact) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(contact: contact);
    prefsDao.upsert(newPrefs);
    emit(PrefsLoaded(prefs: newPrefs));
  }

  Future<void> saveDeviceName(String name) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(deviceName: name);
    prefsDao.upsert(newPrefs);
    emit(PrefsLoaded(prefs: newPrefs));
  }
}
