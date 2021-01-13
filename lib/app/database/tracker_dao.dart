import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/tracker_data.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

class TrackerDao {
  static const int _key = 0;
  final Future<Box<TrackerData>> _trackerDataBox;

  TrackerDao(String userId)
      : _trackerDataBox = Hive.openBox('$userId/${HiveBoxNames.trackerData}');

  Future<TrackerData> get() async {
    final box = await _trackerDataBox;
    return box.get(_key, defaultValue: const TrackerData());
  }

  Future<void> upsert(TrackerData data) async {
    final box = await _trackerDataBox;
    box.put(_key, data);
  }

  Future<void> delete() async {
    final box = await _trackerDataBox;
    await box.clear();
  }
}
