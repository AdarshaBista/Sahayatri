import 'dart:async';
import 'dart:math';

import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';

class TrackerService {
  /// The [Destination] this service is currently tracking.
  /// If destination is null, there is no tracking occuring.
  Destination _destination;

  /// Keeps track of time spent on tracking.
  final Stopwatch _stopwatch = Stopwatch();

  /// Get continuous location updates.
  StreamController<UserLocation> _userLocationStreamController;
  Stream<UserLocation> get userLocationStream => _userLocationStreamController.stream;

  /// Subscription to user location stream.
  StreamSubscription _userLocationStreamSub;

  /// Called when user completes the trail
  void Function() onCompleted;

  /// Start the tracking process for a [destination].
  Future<void> start(Destination destination) async {
    /// If [_destination] is not null, tacking is already in progress.
    if (_destination != null) {
      if (destination.id != _destination.id) {
        throw Failure(error: 'Tracking is already occuring for another destination.');
      }

      // Resume tracking process.
      // Does not do anything on initial start.
      // Ensures tracking is resumed when starting from paused state.
      resume();
      return;
    }

    _stopwatch.start();
    _destination = destination;

    _userLocationStreamController = StreamController<UserLocation>.broadcast();
    _userLocationStreamSub = _getUserLocationStream().listen((userLocation) {
      _userLocationStreamController.add(userLocation);
    });

    /// Call [onCompleted] when user finishes trail.
    _userLocationStreamSub.onDone(() => onCompleted());
  }

  /// Stop the tracking process and reset fields.
  void stop() {
    _destination = null;

    _stopwatch?.reset();
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

  // TODO: Remove function parameter
  /// Get user location to determine wheather tracking can be started.
  Future<UserLocation> getUserLocation(Coord fakeStartingPoint) async {
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

  // TODO: This should get updates from LocationService.
  /// Get location updates once tracking has started.
  Stream<UserLocation> _getUserLocationStream() {
    return Stream<UserLocation>.periodic(
      const Duration(milliseconds: 300),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 1.0 + _randomOffset(-1.0, 1.0),
        bearing: _randomOffset(0.0, 360.0),
        timestamp: DateTime.now(),
        coord: _destination.route[index],
      ),
    ).take(_destination.route.length).asBroadcastStream();
  }

  // TODO: Remove this
  double _randomOffset(double start, double end) {
    return Random().nextDouble() * (end - start) + start;
  }

  /// Check if user is near the trail.
  /// Tracking is only started if this returns true.
  bool isNearTrail(Coord userCoord, List<Coord> route) {
    return PolygonUtil.isLocationOnPath(
      LatLng(userCoord.lat, userCoord.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: Distances.kMinNearbyDistance * 4.0,
    );
  }

  /// Get the time since tracking started.
  Duration getElapsedDuration() {
    return _stopwatch.elapsed;
  }

  /// Get the distance covered by the user in metres.
  double getDistanceCovered(int userIndex) {
    final path = _destination.route
        .take(userIndex)
        .map(
          (p) => LatLng(p.lat, p.lng),
        )
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  /// Get the remaining distance on the route.
  double getDistanceRemaining(int userIndex) {
    final path = _destination.route
        .getRange(userIndex, _destination.route.length - 1)
        .map((p) => LatLng(p.lat, p.lng))
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  /// Get the [NextStop] the user is approaching along the route.
  NextStop getNextStop(UserLocation userLocation) {
    int userIndex;
    int placeIndex;
    Place nextStopPlace;

    for (final place in _destination.places) {
      userIndex = getIndexOnRoute(userLocation.coord);
      placeIndex = getIndexOnRoute(place.coord);

      if (userIndex >= placeIndex) continue;
      nextStopPlace = place;
      break;
    }
    if (nextStopPlace == null) return null;

    final double distance = _getNextStopDistance(userIndex, placeIndex);
    final int eta = userLocation.speed < 0.1 ? null : distance ~/ userLocation.speed;

    return NextStop(
      distance: distance,
      place: nextStopPlace,
      eta: eta == null ? null : Duration(seconds: eta),
    );
  }

  /// Get distance to place in [NextStop]
  double _getNextStopDistance(int userIndex, int placeIndex) {
    final path = _destination.route
        .getRange(userIndex, placeIndex)
        .map((p) => LatLng(
              p.lat,
              p.lng,
            ))
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  /// Get index of a [point] on the route.
  /// This index determines the position of [point] along a route.
  int getIndexOnRoute(Coord point, [double tolerance = Distances.kNextStopTolerance]) {
    return PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      _destination.route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: tolerance,
    );
  }
}
