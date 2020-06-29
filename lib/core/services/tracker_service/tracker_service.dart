import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  static const double kMinNearbyDistance = 50.0;
  bool isAlreadyAlerted = false;

  Future<UserLocation> getUserLocation();
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

  Place getNextStop(Coord userLocation, List<Place> places, List<Coord> route) {
    for (final place in places) {
      final userIndex = _getIndexOnRoute(userLocation, route);
      final placeIndex = _getIndexOnRoute(place.coord, route);

      if (userIndex >= placeIndex) continue;
      return place;
    }
    return null;
  }

  int _getIndexOnRoute(Coord point, List<Coord> route) {
    return PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: kMinNearbyDistance * 3.0,
    );
  }
}
