import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

class PrefsDao {
  static const int _prefsKey = 0;
  Future<Box<Prefs>> _prefsBox;

  void init(String userId) {
    _prefsBox = Hive.openBox('$userId/${HiveConfig.prefsBoxName}');
  }

  Future<Prefs> get() async {
    final box = await _prefsBox;
    return box.get(_prefsKey, defaultValue: const Prefs());
  }

  Future<void> upsert(Prefs prefs) async {
    final box = await _prefsBox;
    box.put(_prefsKey, prefs);
  }
}
