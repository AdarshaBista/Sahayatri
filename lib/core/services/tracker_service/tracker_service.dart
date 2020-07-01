import 'dart:async';

import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  static const double kMinNearbyDistance = 50.0;
  static const double kNextStopTolerance = 50.0;

  final Stopwatch stopwatch = Stopwatch();
  bool isAlreadyAlerted = false;
  bool hasStarted = false;

  void start() {
    if (hasStarted) return;
    stopwatch.reset();
    stopwatch.start();
    hasStarted = true;
  }

  void stop() {
    stopwatch.stop();
    hasStarted = false;
  }

  Future<UserLocation> getUserLocation(Coord initialPoint);
  Stream<UserLocation> getLocationStream(List<Coord> route);

  bool isNearTrail(Coord userLocation, List<Coord> route) {
    return PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: kMinNearbyDistance * 4.0,
    );
  }

  bool shouldAlertUser(Coord userLocation, List<Coord> route) {
    final bool isOnRoute = PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: kMinNearbyDistance,
    );

    if (!isOnRoute && isAlreadyAlerted) return false;
    if (!isOnRoute && !isAlreadyAlerted) return isAlreadyAlerted = true;
    return isAlreadyAlerted = false;
  }

  Duration getElapsedDuration() {
    return stopwatch.elapsed;
  }

  int getUserIndex(Coord userLocation, List<Coord> route) {
    return _getIndexOnRoute(userLocation, route, 0.1);
  }

  double getDistanceWalked(int userIndex, List<Coord> route) {
    final path = route.take(userIndex).map((p) => LatLng(p.lat, p.lng)).toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  double getDistanceRemaining(int userIndex, List<Coord> route) {
    final path = route
        .getRange(userIndex, route.length - 1)
        .map((p) => LatLng(p.lat, p.lng))
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  Place getNextStop(Coord userLocation, List<Place> places, List<Coord> route) {
    for (final place in places) {
      final userIndex = _getIndexOnRoute(userLocation, route);
      final placeIndex = _getIndexOnRoute(place.coord, route);

      if (userIndex >= placeIndex) continue;
      return place;
    }
    return null;
  }

  Duration getEta(UserLocation userLocation, Place nextStop, List<Coord> route) {
    if (userLocation.speed < 0.1 || nextStop == null) return null;

    final userIndex = _getIndexOnRoute(userLocation.coord, route);
    final placeIndex = _getIndexOnRoute(nextStop.coord, route);
    final path =
        route.getRange(userIndex, placeIndex).map((p) => LatLng(p.lat, p.lng)).toList();

    final double distance = SphericalUtil.computeLength(path).toDouble();
    final double etaInSeconds = distance / userLocation.speed;
    return Duration(seconds: etaInSeconds.toInt());
  }

  int _getIndexOnRoute(Coord point, List<Coord> route,
      [double tolerance = kNextStopTolerance]) {
    return PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: tolerance,
    );
  }
}
