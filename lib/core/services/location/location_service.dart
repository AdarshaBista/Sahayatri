import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

abstract class LocationService {
  Future<void> setLocationAccuracy(String accuracy);
  Stream<UserLocation> getLocationStream(List<Coord> route);
  Future<UserLocation> getLocation(Coord fakeStartingPoint);
}
