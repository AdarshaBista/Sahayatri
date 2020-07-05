import 'dart:async';
import 'dart:math';

import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
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
  final _locationStreamController = StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  /// Start the tracking proces for a [destination].
  void start(Destination destination) {
    if (_destination != null) return;
    _destination = destination;

    _stopwatch.reset();
    _stopwatch.start();

    _getUserLocationStream().listen((userLocation) {
      _locationStreamController.add(userLocation);
    });
  }

  /// Stop the tracking proces and reset fields.
  void stop() {
    _destination = null;

    _stopwatch.stop();
    _locationStreamController.close();
  }

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
    ).take(_destination.route.length);
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

  /// Get the index of user on the route.
  /// This index determines the position of user along a route.
  int getUserIndex(Coord userCoord) {
    return _getIndexOnRoute(userCoord, 0.1);
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
      userIndex = _getIndexOnRoute(userLocation.coord);
      placeIndex = _getIndexOnRoute(place.coord);

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
  int _getIndexOnRoute(Coord point, [double tolerance = Distances.kNextStopTolerance]) {
    return PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      _destination.route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: tolerance,
    );
  }
}
