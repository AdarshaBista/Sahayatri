import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user_location.dart';
import 'package:sahayatri/core/models/next_checkpoint.dart';

enum TrackingState { updating, paused, stopped }

class TrackerUpdate {
  final int userIndex;
  final Duration elapsed;
  final double distanceCovered;
  final double distanceRemaining;
  final TrackingState trackingState;
  final List<UserLocation> userTrack;
  final NextCheckpoint nextCheckpoint;

  UserLocation get currentLocation => userTrack.last;

  TrackerUpdate({
    @required this.elapsed,
    @required this.userIndex,
    @required this.userTrack,
    @required this.nextCheckpoint,
    @required this.distanceCovered,
    @required this.distanceRemaining,
    this.trackingState = TrackingState.updating,
  })  : assert(userIndex != null),
        assert(userTrack != null),
        assert(trackingState != null),
        assert(distanceCovered != null),
        assert(distanceRemaining != null);

  TrackerUpdate copyWith({
    int userIndex,
    Duration elapsed,
    double distanceCovered,
    double distanceRemaining,
    TrackingState trackingState,
    List<UserLocation> userTrack,
    NextCheckpoint nextCheckpoint,
  }) {
    return TrackerUpdate(
      elapsed: elapsed ?? this.elapsed,
      userIndex: userIndex ?? this.userIndex,
      userTrack: userTrack ?? this.userTrack,
      trackingState: trackingState ?? this.trackingState,
      nextCheckpoint: nextCheckpoint ?? this.nextCheckpoint,
      distanceCovered: distanceCovered ?? this.distanceCovered,
      distanceRemaining: distanceRemaining ?? this.distanceRemaining,
    );
  }
}
