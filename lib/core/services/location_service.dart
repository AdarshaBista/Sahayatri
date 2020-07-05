import 'dart:async';
import 'dart:io';

import 'package:location/location.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

class LocationService {
  static const int kLocationIntervalMs = 3000;
  static const double kLocationDistanceFilter = 10.0;

  final Location location = Location();

  /// Wheather the user has granted location permission
  bool _hasPermission = false;

  LocationService() {
    if (Platform.isWindows) return;

    // Check for permission and request if needed
    location.hasPermission().then((value) {
      if (value != PermissionStatus.granted) {
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
      throw Failure(error: 'Location permission denied.');
    }

    return location.onLocationChanged
        .where((locationData) => locationData != null)
        .map((locationData) => UserLocation.fromLocationData(locationData));
  }

  /// One time location query.
  Future<UserLocation> getLocation() async {
    if (Platform.isWindows) {
      throw Failure(error: 'Platform not supported.');
    }

    if (!_hasPermission) {
      throw Failure(error: 'Location permission denied.');
    }

    try {
      final locationData = await location.getLocation();
      return UserLocation.fromLocationData(locationData);
    } catch (e) {
      throw Failure(
        error: e.toString(),
        message: 'Could not get location!',
      );
    }
  }
}
