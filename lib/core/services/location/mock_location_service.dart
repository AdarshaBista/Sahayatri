import 'dart:math';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/services/location/location_service.dart';

class MockLocationService implements LocationService {
  String _accuracy = GpsAccuracy.high;
  static const _accuracyMap = {
    GpsAccuracy.high: 0.00005,
    GpsAccuracy.balanced: 0.0001,
    GpsAccuracy.low: 0.0005,
  };

  /// Sets accuracy of location data.
  @override
  Future<void> setLocationAccuracy(String accuracy) async {
    _accuracy = accuracy;
  }

  /// Get the stream of location as [UserLocation].
  @override
  Stream<UserLocation> getLocationStream(List<Coord> route) {
    final period = Random().nextInt(1000) + 500;
    final offset = _accuracyMap[_accuracy];

    double _randomOffset(double start, double end) {
      return Random().nextDouble() * (end - start) + start;
    }

    return Stream<UserLocation>.periodic(
      Duration(milliseconds: period),
      (index) => UserLocation(
        timestamp: DateTime.now(),
        altitude: route[index].alt,
        bearing: _randomOffset(0.0, 360.0),
        speed: 1.5 + _randomOffset(-1.0, 1.0),
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        coord: Coord(
          lat: route[index].lat,
          lng: route[index].lng + _randomOffset(-offset, offset),
        ),
      ),
    ).take(route.length).asBroadcastStream();
  }

  /// One time location query.
  @override
  Future<UserLocation> getLocation(Coord fakeStartingPoint) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return UserLocation(
      coord: fakeStartingPoint,
      accuracy: 15.0,
      altitude: 2000.0,
      speed: 1.0,
      bearing: 0.0,
      timestamp: DateTime.now(),
    );
  }
}
