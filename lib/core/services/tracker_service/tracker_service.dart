import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  Future<UserLocation> getUserLocation();
  Stream<UserLocation> getLocationStream();
  Future<bool> isNearTrailHead(Coord trailHeadCoord, Coord userLocationCoord);
  bool shouldAlertUser(Coord userLocation, List<Coord> route);
}
