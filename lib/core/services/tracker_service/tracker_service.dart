import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  final double minNearbyDistance = 50.0;

  Future<UserLocation> getUserLocation();
  Stream<UserLocation> getLocationStream();
  Future<bool> isNearTrail(Coord userLocation, List<Coord> route);
  bool shouldAlertUser(Coord userLocation, List<Coord> route);
}
