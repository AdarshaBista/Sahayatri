import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/place.dart';

class NextStop {
  final Place place;
  final Duration eta;
  final double distance;

  NextStop({
    @required this.eta,
    @required this.place,
    @required this.distance,
  })  : assert(place != null),
        assert(distance != null);

  NextStop copyWith({
    Place place,
    Duration eta,
    double distance,
  }) {
    return NextStop(
      place: place ?? this.place,
      eta: eta ?? this.eta,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place?.toMap(),
      'eta': eta?.inSeconds,
      'distance': distance,
    };
  }

  factory NextStop.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NextStop(
      place: Place.fromMap(map['place'] as Map<String, dynamic>),
      eta: Duration(seconds: map['eta'] as int),
      distance: map['distance'] as double,
    );
  }

  @override
  String toString() => 'NextStop(place: $place, eta: $eta, distance: $distance)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NextStop && o.place == place && o.eta == eta && o.distance == distance;
  }

  @override
  int get hashCode => place.hashCode ^ eta.hashCode ^ distance.hashCode;
}
