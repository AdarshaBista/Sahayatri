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

  Future<void> changeMapLayer(String mapStyle) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(mapStyle: mapStyle);
    _updatePrefs(newPrefs);
  }

  Future<void> saveContact(String contact) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(contact: contact);
    _updatePrefs(newPrefs);
  }

  Future<void> saveDeviceName(String name) async {
    final newPrefs = (state as PrefsLoaded).prefs.copyWith(deviceName: name);
    _updatePrefs(newPrefs);
  }

  void _updatePrefs(Prefs newPrefs) {
    prefsDao.upsert(newPrefs);
    emit(PrefsLoaded(prefs: newPrefs));
  }
}
