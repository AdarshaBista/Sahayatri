import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

class PrefsDao {
  static const int _prefsKey = 0;
  final Future<Box<Prefs>> _prefsBox;

  PrefsDao(String userId) : _prefsBox = Hive.openBox('$userId/${HiveBoxNames.prefs}');

  Future<Prefs> get() async {
    final box = await _prefsBox;
    return box.get(_prefsKey, defaultValue: const Prefs());
  }

  Future<void> upsert(Prefs prefs) async {
    final box = await _prefsBox;
    box.put(_prefsKey, prefs);
  }
}
