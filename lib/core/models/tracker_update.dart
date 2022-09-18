import 'dart:math' as math;

import 'package:sahayatri/core/models/next_checkpoint.dart';
import 'package:sahayatri/core/models/user_location.dart';

enum TrackingState { updating, paused, stopped }

class TrackerUpdate {
  final int userIndex;
  final bool isOffRoute;
  final double distanceCovered;
  final double distanceRemaining;
  final TrackingState trackingState;
  final List<UserLocation> userTrack;
  final NextCheckpoint? nextCheckpoint;

  UserLocation get currentLocation => userTrack.last;
  double get topSpeed => userTrack.map((t) => t.speed).reduce(math.max);
  double get averageSpeed =>
      (userTrack.map((t) => t.speed).reduce((a, b) => a + b)) / userTrack.length;

  const TrackerUpdate({
    required this.userIndex,
    required this.userTrack,
    required this.isOffRoute,
    required this.nextCheckpoint,
    required this.distanceCovered,
    required this.distanceRemaining,
    this.trackingState = TrackingState.updating,
  });

  TrackerUpdate copyWith({
    int? userIndex,
    bool? isOffRoute,
    Duration? elapsed,
    double? distanceCovered,
    double? distanceRemaining,
    TrackingState? trackingState,
    List<UserLocation>? userTrack,
    NextCheckpoint? nextCheckpoint,
  }) {
    return TrackerUpdate(
      userIndex: userIndex ?? this.userIndex,
      userTrack: userTrack ?? this.userTrack,
      isOffRoute: isOffRoute ?? this.isOffRoute,
      trackingState: trackingState ?? this.trackingState,
      nextCheckpoint: nextCheckpoint ?? this.nextCheckpoint,
      distanceCovered: distanceCovered ?? this.distanceCovered,
      distanceRemaining: distanceRemaining ?? this.distanceRemaining,
    );
  }
}
