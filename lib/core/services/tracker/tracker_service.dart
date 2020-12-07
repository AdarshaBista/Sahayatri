import 'dart:async';

import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/models/next_checkpoint.dart';

import 'package:sahayatri/core/utils/geo_utils.dart';

import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/tracker/stopwatch_service.dart';

import 'package:sahayatri/app/constants/configs.dart';

class TrackerService {
  /// Location updates from GPS.
  final LocationService locationService;

  /// Keeps track of time spent by the user on this trail.
  final StopwatchService stopwatchService;

  /// The [Destination] this service is currently tracking.
  Destination _destination;

  /// If destination is null, there is no tracking in progress.
  bool get isTracking => _destination != null;

  /// Called when user finishes the trail.
  void Function() onCompleted;

  /// Track covered by user.
  final Set<UserLocation> _userTrack = {};

  /// Tracker update subscription.
  StreamSubscription<TrackerUpdate> _trackerStreamSub;

  /// Continuous tracker updates.
  StreamController<TrackerUpdate> _trackerStreamController;
  Stream<TrackerUpdate> get trackerUpdateStream => _trackerStreamController.stream;

  TrackerService({
    @required this.stopwatchService,
    @required this.locationService,
  })  : assert(stopwatchService != null),
        assert(locationService != null);

  /// Start the tracking process for a [destination].
  Future<void> start(Destination destination) async {
    if (isTracking) {
      if (destination.id != _destination.id) {
        throw const AppError(
          message: 'Tracking is already in progress for another destination.',
        );
      }
      // Ensures tracking is resumed when starting from paused state.
      resume();
      return;
    }

    _destination = destination;
    await stopwatchService.start(destination.id);
    _initTrackerStream();
  }

  void _initTrackerStream() {
    _trackerStreamController = StreamController<TrackerUpdate>.broadcast();
    _trackerStreamSub = locationService.getMockLocationStream(_destination.route).map(
      (userLocation) {
        if (_checkCompleted(userLocation.coord)) onCompleted();

        _userTrack.add(userLocation);
        final index = _userIndex(userLocation.coord);
        return TrackerUpdate(
          userIndex: index,
          userTrack: _userTrack.toList(),
          nextCheckpoint: _nextCheckpoint(userLocation),
          distanceCovered: _distanceCovered(index),
          distanceRemaining: _distanceRemaining(index),
        );
      },
    ).listen((trackerUpdate) {
      _trackerStreamController.add(trackerUpdate);
    });
  }

  /// Check wheather the user has reached the end of trail
  bool _checkCompleted(Coord userCoord) {
    final distance = GeoUtils.computeDistance(userCoord, _destination.route.last);
    return distance < LocationConfig.minNearbyDistance;
  }

  /// Stop the tracking process and reset fields.
  Future<void> stop() async {
    if (!isTracking) return;

    _destination = null;
    _userTrack?.clear();
    await stopwatchService.stop();
    await _trackerStreamSub?.cancel();
    await _trackerStreamController?.close();
  }

  /// Pause the tracking process
  void pause() {
    stopwatchService.pause();
    _trackerStreamSub?.pause();
  }

  /// Resume the tracking process
  void resume() {
    stopwatchService.resume();
    _trackerStreamSub?.resume();
  }

  /// Check if user is near the trail.
  /// Tracking is only started if this returns true.
  Future<bool> isNearTrail(List<Coord> route) async {
    try {
      final userLocation = await locationService.getMockLocation(route.first);
      return GeoUtils.isOnPath(
        userLocation.coord,
        route,
        LocationConfig.minNearbyDistance * 2.0,
      );
    } on AppError {
      rethrow;
    }
  }

  /// The index of user on route.
  int _userIndex(Coord userCoord) {
    return GeoUtils.indexOnPath(userCoord, _destination.route);
  }

  /// Distance covered by the user in metres.
  double _distanceCovered(int userIndex) {
    return GeoUtils.distanceBetweenIndices(_destination.route, end: userIndex);
  }

  /// Remaining distance on the route.
  double _distanceRemaining(int userIndex) {
    return GeoUtils.distanceBetweenIndices(
      _destination.route,
      start: userIndex,
      end: _destination.route.length,
    );
  }

  /// [NextCheckpoint] the user is approaching along the route.
  NextCheckpoint _nextCheckpoint(UserLocation userLocation) {
    Checkpoint nextCheckpoint;
    int userIndex, placeIndex;

    for (final checkpoint in _destination.createdItinerary.checkpoints) {
      userIndex = GeoUtils.indexOnPath(userLocation.coord, _destination.route);
      placeIndex = GeoUtils.indexOnPath(checkpoint.place.coord, _destination.route);

      if (userIndex >= placeIndex) continue;
      nextCheckpoint = checkpoint;
      break;
    }
    if (nextCheckpoint == null) return null;

    final double distance = GeoUtils.distanceBetweenIndices(
      _destination.route,
      start: userIndex,
      end: placeIndex,
    );
    final int eta = userLocation.speed < 0.1 ? null : distance ~/ userLocation.speed;

    return NextCheckpoint(
      distance: distance,
      checkpoint: nextCheckpoint,
      eta: eta == null ? null : Duration(seconds: eta),
    );
  }
}