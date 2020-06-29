import 'dart:math';

import 'package:sahayatri/app/constants/mocks.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

class MockTrackerService extends TrackerService {
  double _randomOffset(double start, double end) {
    return Random().nextDouble() * (end - start) + start;
  }

  @override
  Stream<UserLocation> getLocationStream(List<Coord> route) {
    return Stream<UserLocation>.periodic(
      const Duration(milliseconds: 200),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 5.0 + _randomOffset(-2.0, 2.0),
        bearing: 90.0 + _randomOffset(-90.0, 90.0),
        timestamp: DateTime.now(),
        coord: Coord(
          lat: routePoints[index].lat + _randomOffset(-0.0005, 0.0005),
          lng: routePoints[index].lng,
        ),
      ),
    ).take(routePoints.length).asBroadcastStream();
  }

  @override
  Future<UserLocation> getUserLocation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return UserLocation(
      coord: routePoints[0],
      accuracy: 15.0 + _randomOffset(-5.0, 5.0),
      altitude: 2000.0 + _randomOffset(-50.0, 50.0),
      speed: 5.0 + _randomOffset(-2.0, 2.0),
      bearing: 90 + _randomOffset(-90, 90.0),
      timestamp: DateTime.now(),
    );
  }
}
