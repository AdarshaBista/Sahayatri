import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:location/location.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/app/constants/configs.dart';

class LocationService {
  final Location location = Location();

  LocationService() {
    if (Platform.isWindows) return;

    location.changeSettings(
      interval: LocationConfig.interval,
      distanceFilter: LocationConfig.distanceFilter,
    );
  }

  /// Check if user has granted permission to use location.
  Future<bool> _checkPermission() async {
    PermissionStatus permissionStatus;
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) return true;

    permissionStatus = await location.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  /// Get the stream of location as [UserLocation].
  Stream<UserLocation> getLocationStream() {
    _checkPermission().then((hasPermission) {
      if (!hasPermission) {
        throw const AppError(message: 'Location permission denied.');
      }
    });

    return location.onLocationChanged
        .where((locationData) => locationData != null)
        .map((locationData) => UserLocation.fromLocationData(locationData))
        .asBroadcastStream();
  }

  /// One time location query.
  Future<UserLocation> getLocation() async {
    if (Platform.isWindows) {
      throw const AppError(message: 'Platform not supported.');
    }

    if (!await _checkPermission()) {
      throw const AppError(message: 'Location permission denied.');
    }

    try {
      final locationData = await location.getLocation();
      return UserLocation.fromLocationData(locationData);
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Could not get your location.');
    }
  }

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

  Stream<UserLocation> getMockLocationStream(List<Coord> route) {
    final period = Random().nextInt(1000) + 500;
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
