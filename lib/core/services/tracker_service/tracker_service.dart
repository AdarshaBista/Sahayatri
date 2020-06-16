import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  static const double kMinNearbyDistance = 50.0;

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
    return !PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: kMinNearbyDistance,
    );
  }
}
