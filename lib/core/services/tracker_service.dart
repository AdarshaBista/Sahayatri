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
  void start(Destination destination) {
    /// If [_destination] is not null, tacking is already in progress.
    if (_destination != null) {
      if (destination.id != _destination.id) {
        throw Failure(error: 'Tracking is already occuring for another destination.');
      }

      // Ensures tracking is resumed when starting from paused state.
      resume();
      return;
    }

    _stopwatch.reset();
    _stopwatch.start();
    _destination = destination;

    _userLocationStreamController = StreamController<UserLocation>.broadcast();
    _userLocationStreamSub = _getMockUserLocationStream().listen((userLocation) {
      _userLocationStreamController.add(userLocation);
    });
    // _userLocationStreamSub = locationService.getLocationStream().listen((userLocation) {
    //   _userLocationStreamController.add(userLocation);
    // });

    /// Call [onCompleted] when user finishes trail.
    _userLocationStreamSub.onDone(() => onCompleted());
  }

  /// Stop the tracking process and reset fields.
  void stop() {
    _destination = null;

    _stopwatch.stop();
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

  // TODO: Remove this
  Future<UserLocation> getMockUserLocation(Coord fakeStartingPoint) async {
    await Future.delayed(const Duration(milliseconds: 50));
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
  Stream<UserLocation> _getMockUserLocationStream() {
    return Stream<UserLocation>.periodic(
      const Duration(milliseconds: 200),
      (index) => UserLocation(
        accuracy: 15.0 + _randomOffset(-5.0, 5.0),
        altitude: 2000.0 + _randomOffset(-50.0, 50.0),
        speed: 1.0 + _randomOffset(-1.0, 1.0),
        bearing: _randomOffset(0.0, 360.0),
        timestamp: DateTime.now(),
        coord: Coord(
          lat: _destination.route[index].lat,
          lng: _destination.route[index].lng + _randomOffset(-0.0001, 0.0001),
        ),
      ),
    ).take(_destination.route.length).asBroadcastStream();
  }

  // TODO: Remove this
  double _randomOffset(double start, double end) {
    return math.Random().nextDouble() * (end - start) + start;
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
    return _distanceBetweenIndices(start: userIndex, end: _destination.route.length);
  }

  /// [NextStop] the user is approaching along the route.
  NextStop nextStop(UserLocation userLocation) {
    Place nextStopPlace;
    int userIndex, placeIndex;

    for (final place in _destination.places) {
      userIndex = indexOnRoute(userLocation.coord);
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

  /// Index of a [Coord] closest to a [point] on the route.
  /// This index determines the position of [point] along a route.
  int indexOnRoute(Coord point) {
    Coord nearestCoord;
    double shortestDistanceSq = double.infinity;

    for (final coord in _destination.route) {
      final distanceSq = math.pow(coord.lng - point.lng, 2).toDouble() +
          math.pow(coord.lat - point.lat, 2).toDouble();

      if (distanceSq < shortestDistanceSq) {
        nearestCoord = coord;
        shortestDistanceSq = distanceSq;
      }
    }
    return _destination.route.indexOf(nearestCoord);
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
