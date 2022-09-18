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
    required this.coord,
    required this.accuracy,
    required this.altitude,
    required this.speed,
    required this.bearing,
    required this.timestamp,
  });

  UserLocation copyWith({
    Coord? coord,
    double? accuracy,
    double? altitude,
    double? speed,
    double? bearing,
    DateTime? timestamp,
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
    return UserLocation(
      coord: Coord(
        lat: locationData.latitude ?? 0.0,
        lng: locationData.longitude ?? 0.0,
      ),
      altitude: locationData.altitude ?? 0.0,
      bearing: locationData.heading ?? 0.0,
      speed: locationData.speed ?? 0.0,
      accuracy: locationData.accuracy ?? 0.0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(locationData.time?.toInt() ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coord': coord.toMap(),
      'accuracy': accuracy,
      'altitude': altitude,
      'speed': speed,
      'bearing': bearing,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      coord: Coord.fromMap(map['coord']),
      accuracy: map['accuracy']?.toDouble() ?? 0.0,
      altitude: map['altitude']?.toDouble() ?? 0.0,
      speed: map['speed']?.toDouble() ?? 0.0,
      bearing: map['bearing']?.toDouble() ?? 0.0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  @override
  String toString() {
    return 'UserLocation(coord: $coord, accuracy: $accuracy, altitude: $altitude, speed: $speed, bearing: $bearing, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLocation &&
        other.coord == coord &&
        other.accuracy == accuracy &&
        other.altitude == altitude &&
        other.speed == speed &&
        other.bearing == bearing &&
        other.timestamp == timestamp;
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
