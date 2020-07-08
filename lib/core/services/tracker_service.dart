import 'dart:async';
import 'dart:math' as math;

import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:sahayatri/app/constants/resources.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/user_location.dart';

import 'package:sahayatri/core/services/location_service.dart';

class TrackerService {
  /// Location updates from GPS.
  final LocationService locationService;

  /// Keeps track of time spent on tracking.
  final Stopwatch _stopwatch = Stopwatch();

  /// The [Destination] this service is currently tracking.
  /// If destination is null, there is no tracking occuring.
  Destination _destination;

  /// Called when user completes the trail.
  VoidCallback onCompleted;

  /// Subscription to user location stream.
  StreamSubscription _userLocationStreamSub;

  /// Continuous location updates.
  StreamController<UserLocation> _userLocationStreamController;
  Stream<UserLocation> get userLocationStream => _userLocationStreamController.stream;

  TrackerService({
    @required this.locationService,
  }) : assert(locationService != null);

  /// Start the tracking process for a [destination].
  Future<void> start(Destination destination) async {
    /// If [_destination] is not null, tacking is already in progress.
    if (_destination != null) {
      if (destination.id != _destination.id) {
        throw Failure(error: 'Tracking is already occuring for another destination.');
      }

      // Ensures tracking is resumed when starting from paused state.
      resume();
      return;
    }

    _stopwatch.start();
    _destination = destination;

    _userLocationStreamController = StreamController<UserLocation>.broadcast();
    _userLocationStreamSub = locationService.getLocationStream().listen((userLocation) {
      _userLocationStreamController.add(userLocation);
    });

    /// Call [onCompleted] when user finishes trail.
    _userLocationStreamSub.onDone(() => onCompleted());
  }

  /// Stop the tracking process and reset fields.
  void stop() {
    _destination = null;

    _stopwatch?.reset();
    _userLocationStreamSub.cancel();
    _userLocationStreamController.close();
  }

  /// Pause the tracking process
  void pause() {
    _stopwatch.stop();
    _userLocationStreamSub.pause();
  }

  /// Resume the tracking process
  void resume() {
    _stopwatch.start();
    _userLocationStreamSub.resume();
  }

  /// Get user location to determine wheather tracking can be started.
  Future<UserLocation> getUserLocation() async {
    try {
      return await locationService.getLocation();
    } on Failure {
      rethrow;
    }
  }

  /// Check if user is near the trail.
  /// Tracking is only started if this returns true.
  bool isNearTrail(Coord userCoord, List<Coord> route) {
    return PolygonUtil.isLocationOnPath(
      LatLng(userCoord.lat, userCoord.lng),
      route.map((l) => LatLng(l.lat, l.lng)).toList(),
      false,
      tolerance: Distances.kMinNearbyDistance,
    );
  }

  /// Time since tracking started.
  Duration elapsedDuration() {
    return _stopwatch.elapsed;
  }

  /// Distance covered by the user in metres.
  double distanceCovered(int userIndex) {
    return _distanceBetweenIndices(end: userIndex);
  }

  /// Remaining distance on the route.
  double distanceRemaining(int userIndex) {
    return _distanceBetweenIndices(
      start: userIndex,
      end: _destination.route.length - 1,
    );
  }

  /// [NextStop] the user is approaching along the route.
  NextStop nextStop(UserLocation userLocation) {
    Place nextStopPlace;
    int userIndex, placeIndex;

    for (final place in _destination.places) {
      userIndex = indexOnRoute(userLocation.coord, 0.1);
      placeIndex = indexOnRoute(place.coord);

      if (userIndex >= placeIndex) continue;
      nextStopPlace = place;
      break;
    }
    if (nextStopPlace == null) return null;

    final double distance = _distanceBetweenIndices(start: userIndex, end: placeIndex);
    final int eta = userLocation.speed < 0.1 ? null : distance ~/ userLocation.speed;

    return NextStop(
      distance: distance,
      place: nextStopPlace,
      eta: eta == null ? null : Duration(seconds: eta),
    );
  }

  /// Index of a [point] on the route.
  /// This index determines the position of [point] along a route.
  int indexOnRoute(Coord point, [double tolerance = Distances.kMinNearbyDistance]) {
    final index = PolygonUtil.locationIndexOnPath(
      LatLng(point.lat, point.lng),
      _destination.route.map((p) => LatLng(p.lat, p.lng)).toList(),
      false,
      tolerance: tolerance,
    );
    return math.max<int>(0, index);
  }

  /// Get distance between [start] and [end] indices of a route.
  double _distanceBetweenIndices({int start = 0, @required int end}) {
    final path = _destination.route
        .getRange(start, end)
        .map(
          (p) => LatLng(p.lat, p.lng),
        )
        .toList();
    return SphericalUtil.computeLength(path).toDouble();
  }
}
