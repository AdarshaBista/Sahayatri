import 'dart:async';
import 'dart:math' as math;

import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/next_checkpoint.dart';

import 'package:sahayatri/core/utils/geo_utils.dart';
import 'package:sahayatri/core/services/location_service.dart';

import 'package:sahayatri/app/constants/configs.dart';

class TrackerService {
  /// Location updates from GPS.
  final LocationService locationService;

  /// Keeps track of time spent on tracking.
  final Stopwatch _stopwatch = Stopwatch();

  /// The [Destination] this service is currently tracking.
  /// If destination is null, there is no tracking occuring.
  Destination _destination;
  bool get isTracking => _destination != null;

  /// Called when user completes the trail.
  VoidCallback onCompleted;

  /// Subscription to user location stream.
  StreamSubscription _userLocationStreamSub;

  /// Continuous location updates.
  StreamController<UserLocation> _userLocationStreamController;
  Stream<UserLocation> get userLocationStream => _userLocationStreamController.stream;

  TrackerService({
    @required this.locationService,
  }) : assert(locationService != null);

  /// Start the tracking process for a [destination].
  void start(Destination destination) {
    /// If [_destination] is not null, tacking is already in progress.
    if (_destination != null) {
      if (destination.id != _destination.id) {
        throw Failure(error: 'Tracking is already occuring for another destination.');
      }

      // Ensures tracking is resumed when starting from paused state.
      resume();
      return;
    }

    _stopwatch.reset();
    _stopwatch.start();
    _destination = destination;

    _userLocationStreamController = StreamController<UserLocation>.broadcast();
    _userLocationStreamSub = _getMockUserLocationStream().listen((userLocation) {
      _userLocationStreamController.add(userLocation);
    });
    // _userLocationStreamSub = locationService.getLocationStream().listen((userLocation) {
    //   _userLocationStreamController.add(userLocation);
    // });

    /// Call [onCompleted] when user finishes trail.
    _userLocationStreamSub.onDone(() => onCompleted());
  }

  /// Stop the tracking process and reset fields.
  void stop() {
    _destination = null;

    _stopwatch.stop();
    _userLocationStreamSub.cancel();
    _userLocationStreamController.close();
  }

  /// Pause the tracking process
  void pause() {
    _stopwatch.stop();
    _userLocationStreamSub.pause();
  }

  /// Resume the tracking process
  void resume() {
    _stopwatch.start();
    _userLocationStreamSub.resume();
  }

  /// Get user location to determine wheather tracking can be started.
  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on Failure {
      rethrow;
    }
  }

  // TODO: Remove this
  Future<UserLocation> getMockUserLocation(Coord fakeStartingPoint) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return UserLocation(
      coord: fakeStartingPoint,
      accuracy: 15.0,
      altitude: 2000.0,
      speed: 1.0,
      bearing: 0.0,
      timestamp: DateTime.now(),
    );
  }

  // TODO: Remove this
  Stream<UserLocation> _getMockUserLocationStream() {
    final period = math.Random().nextInt(2000) + 2000;
    return Stream<UserLocation>.periodic(
      Duration(milliseconds: period),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 1.0 + _randomOffset(-1.0, 1.0),
        bearing: _randomOffset(0.0, 360.0),
        timestamp: DateTime.now(),
        coord: Coord(
          lat: _destination.route[index].lat,
          lng: _destination.route[index].lng + _randomOffset(-0.0001, 0.0001),
        ),
      ),
    ).take(_destination.route.length).asBroadcastStream();
  }

  // TODO: Remove this
  double _randomOffset(double start, double end) {
    return math.Random().nextDouble() * (end - start) + start;
  }

  /// Check if user is near the trail.
  /// Tracking is only started if this returns true.
  bool isNearTrail(Coord userCoord, List<Coord> route) {
    return GeoUtils.isOnPath(userCoord, route, Distances.kMinNearbyDistance * 2.0);
  }

  /// Time since tracking started.
  Duration elapsedDuration() {
    return _stopwatch.elapsed;
  }

  int userIndex(Coord userCoord) {
    return GeoUtils.indexOnPath(userCoord, _destination.route);
  }

  /// Distance covered by the user in metres.
  double distanceCovered(int userIndex) {
    return GeoUtils.distanceBetweenIndices(_destination.route, end: userIndex);
  }

  /// Remaining distance on the route.
  double distanceRemaining(int userIndex) {
    return GeoUtils.distanceBetweenIndices(
      _destination.route,
      start: userIndex,
      end: _destination.route.length,
    );
  }

  /// [NextCheckpoint] the user is approaching along the route.
  NextCheckpoint nextCheckpoint(UserLocation userLocation) {
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
