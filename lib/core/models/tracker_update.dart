import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/next_checkpoint.dart';
import 'package:sahayatri/core/models/user_location.dart';

enum TrackingState { updating, paused, stopped }

class TrackerUpdate {
  final int userIndex;
  final Duration elapsed;
  final double distanceCovered;
  final double distanceRemaining;
  final UserLocation userLocation;
  final TrackingState trackingState;
  final NextCheckpoint nextCheckpoint;

  TrackerUpdate({
    @required this.elapsed,
    @required this.userIndex,
    @required this.userLocation,
    @required this.nextCheckpoint,
    @required this.distanceCovered,
    @required this.distanceRemaining,
    this.trackingState = TrackingState.updating,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(trackingState != null),
        assert(distanceCovered != null),
        assert(distanceRemaining != null);

  TrackerUpdate copyWith({
    int userIndex,
    Duration elapsed,
    double distanceCovered,
    double distanceRemaining,
    UserLocation userLocation,
    TrackingState trackingState,
    NextCheckpoint nextCheckpoint,
  }) {
    return TrackerUpdate(
      elapsed: elapsed ?? this.elapsed,
      userIndex: userIndex ?? this.userIndex,
      userLocation: userLocation ?? this.userLocation,
      trackingState: trackingState ?? this.trackingState,
      nextCheckpoint: nextCheckpoint ?? this.nextCheckpoint,
      distanceCovered: distanceCovered ?? this.distanceCovered,
      distanceRemaining: distanceRemaining ?? this.distanceRemaining,
    );
  }
}
