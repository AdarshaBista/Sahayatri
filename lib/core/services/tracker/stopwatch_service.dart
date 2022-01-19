import 'dart:async';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/tracker_data.dart';

import 'package:sahayatri/app/database/tracker_dao.dart';

class StopwatchService {
  /// Persist [TrackerData] on local storage.
  final TrackerDao trackerDao = locator();

  /// Keeps track of time spent on tracking.
  final Stopwatch _stopwatch = Stopwatch();

  /// Persisted tracker data.
  late TrackerData _trackerData;

  /// Persisted elapsed value to be added to stopwatch.
  int _initialElapsed = 0;

  Future<void> start(String destinationId) async {
    _stopwatch.reset();
    _stopwatch.start();

    // Get the latest tracker data and set intial elapsed.
    final trackerData = await trackerDao.get();

    // There was no stored tracker data.
    // So, create tracker data for the current session.
    if (trackerData == null || trackerData.destinationId == null) {
      _trackerData = TrackerData(destinationId: destinationId);
      await trackerDao.upsert(_trackerData);
    } else {
      _trackerData = trackerData;

      // The stored tracker data is for another destination.
      // So, delete it and create tracker data for the current session.
      if (_trackerData.destinationId != destinationId) {
        await trackerDao.delete();
        _trackerData = TrackerData(destinationId: destinationId);
        await trackerDao.upsert(_trackerData);
      }
    }
    _initialElapsed = _trackerData.elapsed;
  }

  Future<void> stop() async {
    _stopwatch.stop();
    await trackerDao.delete();
  }

  void pause() {
    _stopwatch.stop();
  }

  void resume() {
    _stopwatch.start();
  }

  Duration elapsed() {
    // Get the elapsed count from the stopwatch
    // and add initial stored elapsed.
    int elapsed = _stopwatch.elapsed.inSeconds;
    elapsed += _initialElapsed;
    _saveElapsed(elapsed);

    return Duration(seconds: elapsed);
  }

  /// Save the current [elapsed] time.
  Future<void> _saveElapsed(int elapsed) async {
    final trackerData = await trackerDao.get();
    if (trackerData == null) return;

    _trackerData = trackerData;
    await trackerDao.upsert(_trackerData.copyWith(elapsed: elapsed));
  }
}
