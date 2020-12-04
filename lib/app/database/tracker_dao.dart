import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

class TrackerDao {
  static const int _key = 0;
  Future<Box<TrackerData>> _trackerDataBox;

  void init(String userId) {
    _trackerDataBox = Hive.openBox('$userId/${HiveConfig.trackerDataBoxName}');
  }

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
    box.clear();
  }
}
