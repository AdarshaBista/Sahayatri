import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class TrackerService {
  Stream<UserLocation> getLocationStream();
  Future<UserLocation> getUserLocation();
  Future<bool> isNearTrailHead(Coord trailHeadCoord, Coord userLocationCoord);
}
