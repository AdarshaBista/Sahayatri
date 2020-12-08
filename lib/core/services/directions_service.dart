import 'package:sahayatri/locator.dart';

// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';

class DirectionsService {
  final LocationService locationService = locator();

  // MapboxNavigation _directions;

  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on AppError {
      rethrow;
    }
  }

  Future<void> startNavigation(
    String name,
    Coord coord,
    UserLocation userLocation,
    // NavigationMode mode,
  ) async {
    // _directions = MapboxNavigation(onRouteProgress: (arrived) async {
    //   if (arrived) await _directions.finishNavigation();
    // });

    // final Location _origin = Location(
    //   name: 'Your location',
    //   latitude: userLocation.coord.lat,
    //   longitude: userLocation.coord.lng,
    // );

    // final Location _destination = Location(
    //   name: name,
    //   latitude: coord.lat,
    //   longitude: coord.lng,
    // );

    // await _directions.startNavigation(
    //   origin: _origin,
    //   destination: _destination,
    //   language: 'en',
    //   units: VoiceUnits.metric,
    //   mode: mode,
    // );
  }
}
