import 'dart:math';

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
      const Duration(milliseconds: 300),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 2.0 + _randomOffset(-2.0, 2.0),
        bearing: 90.0 + _randomOffset(-90.0, 90.0),
        timestamp: DateTime.now(),
        coord: route[index],
      ),
    ).take(route.length).asBroadcastStream();
  }

  @override
  Future<UserLocation> getUserLocation(Coord initialPoint) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return UserLocation(
      coord: initialPoint,
      accuracy: 15.0 + _randomOffset(-5.0, 5.0),
      altitude: 2000.0 + _randomOffset(-50.0, 50.0),
      speed: 5.0 + _randomOffset(-2.0, 2.0),
      bearing: 90 + _randomOffset(-90, 90.0),
      timestamp: DateTime.now(),
    );
  }
}
