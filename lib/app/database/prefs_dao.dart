import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/prefs.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

class PrefsDao {
  static const int prefsKey = 0;
  final Future<Box<Prefs>> _prefsBox = Hive.openBox(HiveConfig.prefsBoxName);

  Future<Prefs> get() async {
    final box = await _prefsBox;
    return box.get(prefsKey, defaultValue: const Prefs());
  }

  Future<void> upsert(Prefs prefs) async {
    final box = await _prefsBox;
    box.put(prefsKey, prefs);
  }
}
