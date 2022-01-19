import 'package:hive/hive.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

import 'package:sahayatri/core/constants/hive_config.dart';

part 'coord.g.dart';

@HiveType(typeId: HiveTypeIds.coord)
class Coord {
  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lng;

  @HiveField(2)
  final double alt;

  const Coord({
    required this.lat,
    required this.lng,
    this.alt = 0.0,
  });

  Coord copyWith({
    double? lat,
    double? lng,
    double? alt,
  }) {
    return Coord(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      alt: alt ?? this.alt,
    );
  }

  LatLng toLatLng() {
    return LatLng(lat, lng);
  }

  factory Coord.fromLatLng(LatLng latLng) {
    return Coord(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
  }

  factory Coord.fromCsv(String coordStr) {
    final List<String> values = coordStr.split(',');
    if (values.length == 2) values.add('0.0');
    final List<double> points =
        values.map((p) => double.tryParse(p) ?? 0.0).toList();

    return Coord(
      lat: points[0],
      lng: points[1],
      alt: points[2],
    );
  }

  String toCsv() {
    return '$lat,$lng,$alt';
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'alt': alt,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      alt: map['alt']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() => 'Coord(lat: $lat, lng: $lng, alt: $alt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coord &&
        other.lat == lat &&
        other.lng == lng &&
        other.alt == alt;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
}
