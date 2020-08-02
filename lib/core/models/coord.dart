import 'package:meta/meta.dart';

import 'package:latlong/latlong.dart';

class Coord {
  final double lat;
  final double lng;
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

  Map<String, dynamic> toMap() {
    return {
      'latitude': lat,
      'longitude': lng,
      'altitude': alt,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coord(
      lat: map['latitude'] as double,
      lng: map['longitude'] as double,
      alt: map['altitude'] as double,
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
