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

  UserLocation _currentLocation;
  UserLocation get currentLocation => _currentLocation;

  TrackerService({
    @required this.locationService,
  }) : assert(locationService != null);

  Stream<UserLocation> getLocationStream() {
    return locationService.getLocationStream();
  }

  Future<bool> isNearTrailHead(Coord trailHeadCoord) async {
    try {
      _currentLocation = await locationService.getLocation();
    } on Failure {
      rethrow;
    }

    final distance = geodesy.distanceBetweenTwoGeoPoints(
      _currentLocation.coord.toLatLng(),
      trailHeadCoord.toLatLng(),
    );
    return distance < kMinNearbyDistance;
  }
}
