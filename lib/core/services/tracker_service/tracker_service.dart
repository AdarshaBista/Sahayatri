import 'dart:async';

import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  final Stopwatch stopwatch = Stopwatch();
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

  bool isNearTrail(Coord userCoord, List<Coord> route) {
    return PolygonUtil.isLocationOnPath(
      LatLng(userCoord.lat, userCoord.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: Distances.kMinNearbyDistance * 4.0,
    );
  }

  Duration getElapsedDuration() {
    return stopwatch.elapsed;
  }

  int getUserIndex(Coord userCoord, List<Coord> route) {
    return _getIndexOnRoute(userCoord, route, 0.1);
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

  NextStop getNextStop(UserLocation userLocation, List<Place> places, List<Coord> route) {
    int userIndex;
    int placeIndex;
    Place nextStopPlace;

    for (final place in places) {
      userIndex = _getIndexOnRoute(userLocation.coord, route);
      placeIndex = _getIndexOnRoute(place.coord, route);

      if (userIndex >= placeIndex) continue;
      nextStopPlace = place;
      break;
    }
    if (nextStopPlace == null) return null;

    final double distance = _getNextStopDistance(userIndex, placeIndex, route);
    final int eta = userLocation.speed < 0.1 ? null : distance ~/ userLocation.speed;

    return NextStop(
      distance: distance,
      place: nextStopPlace,
      eta: eta == null ? null : Duration(seconds: eta),
    );
  }

  double _getNextStopDistance(int userIndex, int placeIndex, List<Coord> route) {
    final path = route
        .getRange(userIndex, placeIndex)
        .map((p) => LatLng(
              p.lat,
              p.lng,
            ))
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }

  int _getIndexOnRoute(Coord point, List<Coord> route,
      [double tolerance = Distances.kNextStopTolerance]) {
    return PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: tolerance,
    );
  }
}
