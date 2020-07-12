import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

class NextCheckpoint {
  final Duration eta;
  final double distance;
  final Checkpoint checkpoint;

  NextCheckpoint({
    @required this.eta,
    @required this.distance,
    @required this.checkpoint,
  })  : assert(distance != null),
        assert(checkpoint != null);

  NextCheckpoint copyWith({
    Duration eta,
    double distance,
    Checkpoint checkpoint,
  }) {
    return NextCheckpoint(
      eta: eta ?? this.eta,
      distance: distance ?? this.distance,
      checkpoint: checkpoint ?? this.checkpoint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eta': eta?.inSeconds,
      'distance': distance,
      'checkpoint': checkpoint?.toMap(),
    };
  }

  factory NextCheckpoint.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NextCheckpoint(
      distance: map['distance'] as double,
      eta: Duration(seconds: map['eta'] as int),
      checkpoint: Checkpoint.fromMap(map['checkpoint'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'NextCheckpoint(checkpoint: $checkpoint, eta: $eta, distance: $distance)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NextCheckpoint &&
        o.eta == eta &&
        o.distance == distance &&
        o.checkpoint == checkpoint;
  }

  @override
  int get hashCode => checkpoint.hashCode ^ eta.hashCode ^ distance.hashCode;
}
