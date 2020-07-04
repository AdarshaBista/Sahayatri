import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/user_location.dart';

class TrackerData {
  final int userIndex;
  final Duration elapsed;
  final NextStop nextStop;
  final double distanceWalked;
  final double distanceRemaining;
  final UserLocation userLocation;

  TrackerData({
    @required this.userIndex,
    @required this.elapsed,
    @required this.nextStop,
    @required this.distanceWalked,
    @required this.distanceRemaining,
    @required this.userLocation,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(distanceWalked != null),
        assert(distanceRemaining != null);
}
