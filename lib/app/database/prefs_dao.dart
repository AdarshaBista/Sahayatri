import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/prefs.dart';

class PrefsDao {
  static const int kPrefsId = 0;
  static const String kPrefsBoxName = 'prefs_box';

  final Future<Box<Prefs>> _prefsBox = Hive.openBox(kPrefsBoxName);

  Future<Prefs> get() async {
    final box = await _prefsBox;
    return box.get(kPrefsId, defaultValue: const Prefs());
  }

  Future<void> upsert(Prefs prefs) async {
    final box = await _prefsBox;
    box.put(kPrefsId, prefs);
  }
}
