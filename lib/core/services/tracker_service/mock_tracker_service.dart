import 'dart:math';

import 'package:sahayatri/app/constants/mocks.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/tracker_service/tracker_service.dart';

class MockTrackerService implements TrackerService {
  double _getOffset(double start, double end) {
    return Random().nextDouble() * (end - start);
  }

  @override
  Stream<UserLocation> getLocationStream() {
    return Stream<UserLocation>.periodic(const Duration(milliseconds: 50), (index) {
      return UserLocation(
        coord: routePoints[index],
        accuracy: 15.0 + _getOffset(-5.0, 5.0),
        altitude: 2000.0 + _getOffset(-50.0, 50.0),
        speed: 5.0 + _getOffset(-2.0, 2.0),
        bearing: 90 + _getOffset(-90, 90.0),
        timestamp: DateTime.now(),
      );
    }).take(routePoints.length).asBroadcastStream();
  }

  @override
  Future<UserLocation> getUserLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    return UserLocation(
      coord: routePoints[0],
      accuracy: 15.0 + _getOffset(-5.0, 5.0),
      altitude: 2000.0 + _getOffset(-50.0, 50.0),
      speed: 5.0 + _getOffset(-2.0, 2.0),
      bearing: 90 + _getOffset(-90, 90.0),
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<bool> isNearTrailHead(Coord trailHeadCoord, Coord userLocationCoord) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
