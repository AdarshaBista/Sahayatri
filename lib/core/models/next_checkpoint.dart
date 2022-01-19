import 'package:sahayatri/core/models/checkpoint.dart';

class NextCheckpoint {
  final Duration? eta;
  final double distance;
  final Checkpoint checkpoint;

  NextCheckpoint({
    required this.eta,
    required this.distance,
    required this.checkpoint,
  });

  NextCheckpoint copyWith({
    Duration? eta,
    double? distance,
    Checkpoint? checkpoint,
  }) {
    return NextCheckpoint(
      eta: eta ?? this.eta,
      distance: distance ?? this.distance,
      checkpoint: checkpoint ?? this.checkpoint,
    );
  }

  factory NextCheckpoint.fromMap(Map<String, dynamic> map) {
    return NextCheckpoint(
      eta: map['eta'] == null ? null : Duration(seconds: map['eta']),
      distance: map['distance']?.toDouble() ?? 0.0,
      checkpoint: Checkpoint.fromMap(map['checkpoint']),
    );
  }

  @override
  String toString() =>
      'NextCheckpoint(checkpoint: $checkpoint, eta: $eta, distance: $distance)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NextCheckpoint &&
        other.eta == eta &&
        other.distance == distance &&
        other.checkpoint == checkpoint;
  }

  @override
  int get hashCode => checkpoint.hashCode ^ eta.hashCode ^ distance.hashCode;
}
