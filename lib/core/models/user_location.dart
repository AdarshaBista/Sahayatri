import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'package:sahayatri/core/models/coord.dart';

class UserLocation {
  final Coord coord;
  final double accuracy;
  final double altitude;
  final double speed;
  final double bearing;
  final DateTime timestamp;

  UserLocation({
    @required this.coord,
    @required this.accuracy,
    @required this.altitude,
    @required this.speed,
    @required this.bearing,
    @required this.timestamp,
  })  : assert(coord != null),
        assert(accuracy != null),
        assert(altitude != null),
        assert(speed != null),
        assert(bearing != null),
        assert(timestamp != null);

  UserLocation copyWith({
    Coord coord,
    double longitude,
    double accuracy,
    double altitude,
    double speed,
    double bearing,
    DateTime timestamp,
  }) {
    return UserLocation(
      coord: coord ?? this.coord,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      speed: speed ?? this.speed,
      bearing: bearing ?? this.bearing,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory UserLocation.fromLocationData(LocationData locationData) {
    if (locationData == null) return null;

    return UserLocation(
      coord: Coord(lat: locationData.latitude, lng: locationData.longitude),
      altitude: locationData.altitude,
      bearing: locationData.heading,
      speed: locationData.speed,
      accuracy: locationData.accuracy,
      timestamp: DateTime.fromMillisecondsSinceEpoch(locationData.time.toInt()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coord': coord.toMap(),
      'accuracy': accuracy,
      'altitude': altitude,
      'speed': speed,
      'bearingDegree': bearing,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLocation(
      coord: Coord.fromMap(map['coord'] as Map<String, dynamic>),
      accuracy: map['accuracy'] as double,
      altitude: map['altitude'] as double,
      speed: map['speed'] as double,
      bearing: map['bearingDegree'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  @override
  String toString() {
    return 'UserLocation(coord: $coord, accuracy: $accuracy, altitude: $altitude, speed: $speed, bearingDegree: $bearing, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserLocation &&
        o.coord == coord &&
        o.accuracy == accuracy &&
        o.altitude == altitude &&
        o.speed == speed &&
        o.bearing == bearing &&
        o.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return coord.hashCode ^
        accuracy.hashCode ^
        altitude.hashCode ^
        speed.hashCode ^
        bearing.hashCode ^
        timestamp.hashCode;
  }
}
