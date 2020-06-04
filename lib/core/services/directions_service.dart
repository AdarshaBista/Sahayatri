import 'package:meta/meta.dart';

import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';

class DirectionsService {
  final LocationService locationService;

  MapboxNavigation _directions;

  DirectionsService({
    @required this.locationService,
  }) : assert(locationService != null);

  Future<void> startNavigation(Place trailHead) async {
    UserLocation currentLocation;

    try {
      currentLocation = await locationService.getLocation();
    } on Failure {
      rethrow;
    }

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      if (arrived) await _directions.finishNavigation();
    });

    Location _origin = Location(
      name: 'Your location',
      latitude: currentLocation.coord.lat,
      longitude: currentLocation.coord.lng,
    );

    Location _destination = Location(
      name: trailHead.name,
      latitude: trailHead.coord.lat,
      longitude: trailHead.coord.lng,
    );

    await _directions.startNavigation(
      origin: _origin,
      destination: _destination,
      language: 'en',
      units: VoiceUnits.metric,
      mode: NavigationMode.driving,
      simulateRoute: false,
    );
  }
}
