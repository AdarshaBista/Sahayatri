import 'package:meta/meta.dart';

import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

class GpsTrackerService extends TrackerService {
  final LocationService locationService;

  GpsTrackerService({
    @required this.locationService,
  }) : assert(locationService != null);

  @override
  Stream<UserLocation> getLocationStream() {
    return locationService.getLocationStream().asBroadcastStream();
  }

  @override
  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<bool> isNearTrail(Coord userLocation, List<Coord> route) async {
    return PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: minNearbyDistance * 4.0,
    );
  }

  @override
  bool shouldAlertUser(Coord userLocation, List<Coord> route) {
    return !PolygonUtil.isLocationOnPath(
      LatLng(userLocation.lat, userLocation.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: minNearbyDistance,
    );
  }
}
