import 'package:meta/meta.dart';

import 'package:geodesy/geodesy.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

class GpsTrackerService implements TrackerService {
  static const double kAlertUserRadius = 50.0;
  static const double kMinNearbyDistance = 200.0;

  final Geodesy geodesy = Geodesy();
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
  Future<bool> isNearTrailHead(Coord trailHeadCoord, Coord userLocationCoord) async {
    final distance = geodesy.distanceBetweenTwoGeoPoints(
      userLocationCoord.toLatLng(),
      trailHeadCoord.toLatLng(),
    );
    return distance < kMinNearbyDistance;
  }

  @override
  bool shouldAlertUser(Coord userLocation, List<Coord> route) {
    return geodesy
        .pointsInRange(
          userLocation.toLatLng(),
          route.map((c) => c.toLatLng()).toList(),
          kAlertUserRadius,
        )
        .isEmpty;
  }
}
