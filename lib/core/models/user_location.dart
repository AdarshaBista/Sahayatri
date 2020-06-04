import 'dart:convert';

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
    double bearingDegree,
    DateTime timestamp,
  }) {
    return UserLocation(
      coord: coord ?? this.coord,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      speed: speed ?? this.speed,
      bearing: bearingDegree ?? this.bearing,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  static UserLocation fromLocationData(LocationData userLocation) {
    if (userLocation == null) return null;

    return UserLocation(
      coord: Coord(lat: userLocation.latitude, lng: userLocation.longitude),
      altitude: userLocation.altitude,
      bearing: userLocation.heading,
      speed: userLocation.speed,
      accuracy: userLocation.accuracy,
      timestamp: DateTime.fromMillisecondsSinceEpoch(userLocation.time.toInt()),
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

  static UserLocation fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserLocation(
      coord: map['coord'],
      accuracy: map['accuracy'],
      altitude: map['altitude'],
      speed: map['speed'],
      bearing: map['bearingDegree'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  static UserLocation fromJson(String source) => fromMap(json.decode(source));

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
