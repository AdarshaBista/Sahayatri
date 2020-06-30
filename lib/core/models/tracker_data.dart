import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/user_location.dart';

class TrackerData {
  final int userIndex;
  final Duration eta;
  final Place nextStop;
  final Duration elapsed;
  final double distanceWalked;
  final double distanceRemaining;
  final UserLocation userLocation;

  TrackerData({
    @required this.userIndex,
    @required this.eta,
    @required this.nextStop,
    @required this.elapsed,
    @required this.distanceWalked,
    @required this.distanceRemaining,
    @required this.userLocation,
  })  : assert(userIndex != null),
        assert(userLocation != null),
        assert(distanceWalked != null),
        assert(distanceRemaining != null);

  TrackerData copyWith({
    int userIndex,
    Duration eta,
    Place nextStop,
    Duration elapsed,
    double distanceWalked,
    double distanceRemaining,
    UserLocation userLocation,
  }) {
    return TrackerData(
      userIndex: userIndex ?? this.userIndex,
      eta: eta ?? this.eta,
      nextStop: nextStop ?? this.nextStop,
      elapsed: elapsed ?? this.elapsed,
      distanceWalked: distanceWalked ?? this.distanceWalked,
      distanceRemaining: distanceRemaining ?? this.distanceRemaining,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userIndex': userIndex,
      'eta': eta?.inSeconds,
      'nextStop': nextStop?.toMap(),
      'elapsed': elapsed?.inSeconds,
      'distanceWalked': distanceWalked,
      'distanceRemaining': distanceRemaining,
      'userLocation': userLocation?.toMap(),
    };
  }

  factory TrackerData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TrackerData(
      userIndex: map['userIndex'] as int,
      eta: Duration(seconds: map['eta'] as int),
      nextStop: Place.fromMap(map['nextStop'] as Map<String, dynamic>),
      elapsed: Duration(seconds: map['elapsed'] as int),
      distanceWalked: map['distanceWalked'] as double,
      distanceRemaining: map['distanceRemaining'] as double,
      userLocation: UserLocation.fromMap(map['userLocation'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'TrackerData(userIndex: $userIndex, eta: $eta, nextStop: $nextStop, elapsed: $elapsed, distanceWalked: $distanceWalked, distanceRemaining: $distanceRemaining, userLocation: $userLocation)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TrackerData &&
        o.userIndex == userIndex &&
        o.eta == eta &&
        o.nextStop == nextStop &&
        o.elapsed == elapsed &&
        o.distanceWalked == distanceWalked &&
        o.distanceRemaining == distanceRemaining &&
        o.userLocation == userLocation;
  }

  @override
  int get hashCode {
    return userIndex.hashCode ^
        eta.hashCode ^
        nextStop.hashCode ^
        elapsed.hashCode ^
        distanceWalked.hashCode ^
        distanceRemaining.hashCode ^
        userLocation.hashCode;
  }
}
