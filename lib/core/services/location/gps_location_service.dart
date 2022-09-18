import 'dart:io';

import 'package:location/location.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/services/location/location_service.dart';

class GpsLocationService implements LocationService {
  final Location location = Location();

  /// The accuracy of location data obtained from GPS.
  String _locationAccuracy = GpsAccuracy.high;
  static const accuracyMap = {
    GpsAccuracy.high: LocationAccuracy.high,
    GpsAccuracy.low: LocationAccuracy.powerSave,
    GpsAccuracy.balanced: LocationAccuracy.balanced,
  };

  GpsLocationService() {
    if (Platform.isWindows) return;

    location.changeSettings(
      interval: LocationConfig.interval,
      accuracy: accuracyMap[_locationAccuracy],
      distanceFilter: LocationConfig.distanceFilter,
    );
  }

  /// Sets accuracy of location data.
  @override
  Future<void> setLocationAccuracy(String accuracy) async {
    if (_locationAccuracy == accuracy) return;
    _locationAccuracy = accuracy;

    await location.changeSettings(accuracy: accuracyMap[accuracy]);
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
  @override
  Stream<UserLocation> getLocationStream(List<Coord> route) {
    _checkPermission().then((hasPermission) {
      if (!hasPermission) {
        throw const AppError(message: 'Location permission denied.');
      }
    });

    return location.onLocationChanged
        .map((locationData) => UserLocation.fromLocationData(locationData))
        .asBroadcastStream();
  }

  /// One time location query.
  @override
  Future<UserLocation> getLocation(Coord fakeStartingPoint) async {
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
}
