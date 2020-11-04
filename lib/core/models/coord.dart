import 'package:meta/meta.dart';

import 'package:hive/hive.dart';

import 'package:latlong/latlong.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

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
    @required this.lat,
    @required this.lng,
    this.alt = 0.0,
  })  : assert(lat != null),
        assert(lng != null),
        assert(alt != null);

  Coord copyWith({
    double lat,
    double lng,
    double alt,
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
    if (latLng == null) return null;

    return Coord(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
  }

  factory Coord.fromCsv(String coordStr) {
    if (coordStr == null || coordStr.isEmpty) return null;

    final List<String> values = coordStr.split(',');
    if (values.length == 2) values.add('0.0');
    final List<double> points = values.map((p) => double.tryParse(p) ?? 0.0).toList();

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
    if (map == null) return null;

    return Coord(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      alt: map['alt'] as double,
    );
  }

  @override
  String toString() => 'Coord(lat: $lat, lng: $lng, alt: $alt)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coord && o.lat == lat && o.lng == lng && o.alt == alt;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ alt.hashCode;
}
