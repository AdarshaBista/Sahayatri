import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/user_alert_service.dart';
import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

class GpsTrackerService extends TrackerService {
  final LocationService locationService;
  final UserAlertService userAlertService;

  GpsTrackerService({
    @required this.locationService,
    @required this.userAlertService,
  })  : assert(locationService != null),
        assert(userAlertService != null);

  @override
  Stream<UserLocation> getLocationStream(List<Coord> route) {
    return locationService.getLocationStream().map((userLocation) {
      if (shouldAlertUser(userLocation.coord, route)) userAlertService.alert();
      return userLocation;
    }).asBroadcastStream();
  }

  @override
  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on Failure {
      rethrow;
    }
  }
}
