import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/user_location.dart';

export './gps_location_service.dart';
export './mock_location_service.dart';

abstract class LocationService {
  Future<void> setLocationAccuracy(String accuracy);
  Stream<UserLocation> getLocationStream(List<Coord> route);
  Future<UserLocation> getLocation(Coord fakeStartingPoint);
}
