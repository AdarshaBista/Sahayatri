import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/user_location.dart';

class TrackerData {
  final int userIndex;
  final Duration elapsed;
  final NextStop nextStop;
  final double distanceCovered;
  final double distanceRemaining;
  final UserLocation userLocation;

  TrackerData({
    @required this.userIndex,
    @required this.elapsed,
    @required this.nextStop,
    @required this.distanceCovered,
    @required this.distanceRemaining,
    @required this.userLocation,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(distanceCovered != null),
        assert(distanceRemaining != null);
}
