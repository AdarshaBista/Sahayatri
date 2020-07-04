import 'dart:async';
import 'dart:io';

import 'package:location/location.dart';

import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

class LocationService {
  final Location location = Location();

  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  LocationService() {
    if (Platform.isWindows) return;
    location.changeSettings(interval: 3000, distanceFilter: 10.0);
    location.hasPermission().then((value) {
      if (value == PermissionStatus.granted) _hasPermission = true;
    });
  }

  Stream<UserLocation> getLocationStream() {
    return location.onLocationChanged
        .where((locationData) => locationData != null)
        .map((locationData) => UserLocation.fromLocationData(locationData));
  }

  Future<UserLocation> getLocation() async {
    if (!hasPermission) {
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
