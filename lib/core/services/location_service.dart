import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:location/location.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

class LocationService {
  static const int kLocationIntervalMs = 2000;
  static const double kLocationDistanceFilter = 10.0;

  final Location location = Location();

  /// Wheather the user has granted location permission
  bool _hasPermission = false;

  LocationService() {
    if (Platform.isWindows) return;

    // Check for permission and request if needed
    location.hasPermission().then((value) {
      if (value == PermissionStatus.granted) {
        _hasPermission = true;
      } else {
        location.requestPermission().then((value) {
          if (value == PermissionStatus.granted) _hasPermission = true;
        });
      }
    });

    location.changeSettings(
      interval: kLocationIntervalMs,
      distanceFilter: kLocationDistanceFilter,
    );
  }

  /// Get the stream of location as [UserLocation].
  Stream<UserLocation> getLocationStream() {
    if (!_hasPermission) {
      throw const Failure(message: 'Location permission denied.');
    }

    return location.onLocationChanged
        .where((locationData) => locationData != null)
        .map((locationData) => UserLocation.fromLocationData(locationData))
        .asBroadcastStream();
  }

  /// One time location query.
  Future<UserLocation> getLocation() async {
    if (Platform.isWindows) {
      throw const Failure(message: 'Platform not supported.');
    }

    if (!_hasPermission) {
      throw const Failure(message: 'Location permission denied.');
    }

    try {
      final locationData = await location.getLocation();
      return UserLocation.fromLocationData(locationData);
    } catch (e) {
      print(e.toString());
      throw const Failure(message: 'Could not get your location.');
    }
  }

  // TODO: Remove this
  Future<UserLocation> getMockLocation(Coord fakeStartingPoint) async {
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

  // TODO: Remove this
  Stream<UserLocation> getMockLocationStream(List<Coord> route) {
    final period = Random().nextInt(500) + 500;
    double _randomOffset(double start, double end) {
      return Random().nextDouble() * (end - start) + start;
    }

    return Stream<UserLocation>.periodic(
      Duration(milliseconds: period),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 1.0 + _randomOffset(-1.0, 1.0),
        bearing: _randomOffset(0.0, 360.0),
        timestamp: DateTime.now(),
        coord: Coord(
          lat: route[index].lat,
          lng: route[index].lng + _randomOffset(-0.00005, 0.00005),
        ),
      ),
    ).take(route.length).asBroadcastStream();
  }
}
