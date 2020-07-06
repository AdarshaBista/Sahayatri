import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/next_stop.dart';
import 'package:sahayatri/core/models/user_location.dart';

enum TrackingState { updating, paused, stopped }

class TrackerUpdate {
  final int userIndex;
  final Duration elapsed;
  final NextStop nextStop;
  final double distanceCovered;
  final double distanceRemaining;
  final UserLocation userLocation;
  final TrackingState trackingState;

  TrackerUpdate({
    @required this.userIndex,
    @required this.elapsed,
    @required this.nextStop,
    @required this.distanceCovered,
    @required this.distanceRemaining,
    @required this.userLocation,
    this.trackingState = TrackingState.updating,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(trackingState != null),
        assert(distanceCovered != null),
        assert(distanceRemaining != null);

  TrackerUpdate copyWith({
    int userIndex,
    Duration elapsed,
    NextStop nextStop,
    double distanceCovered,
    double distanceRemaining,
    UserLocation userLocation,
    TrackingState trackingState,
  }) {
    return TrackerUpdate(
      elapsed: elapsed ?? this.elapsed,
      nextStop: nextStop ?? this.nextStop,
      userIndex: userIndex ?? this.userIndex,
      userLocation: userLocation ?? this.userLocation,
      trackingState: trackingState ?? this.trackingState,
      distanceCovered: distanceCovered ?? this.distanceCovered,
      distanceRemaining: distanceRemaining ?? this.distanceRemaining,
    );
  }
}
