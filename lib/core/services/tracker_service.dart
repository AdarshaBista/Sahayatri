import 'package:meta/meta.dart';

import 'package:geodesy/geodesy.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';

class TrackerService {
  static const kMinNearbyDistance = 200.0;

  final Geodesy geodesy = Geodesy();
  final LocationService locationService;

  TrackerService({
    @required this.locationService,
  }) : assert(locationService != null);

  Stream<UserLocation> getLocationStream() {
    return locationService.getLocationStream();
  }

  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on Failure {
      rethrow;
    }
  }

  Future<bool> isNearTrailHead(Coord trailHeadCoord, Coord userLocationCoord) async {
    final distance = geodesy.distanceBetweenTwoGeoPoints(
      userLocationCoord.toLatLng(),
      trailHeadCoord.toLatLng(),
    );
    return distance < kMinNearbyDistance;
  }
}
