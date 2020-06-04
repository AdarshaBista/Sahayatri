import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:latlong/latlong.dart';

class Coord {
  final double lat;
  final double lng;

  const Coord({
    @required this.lat,
    @required this.lng,
  })  : assert(lat != null),
        assert(lng != null);

  Coord copyWith({
    double lat,
    double lng,
  }) {
    return Coord(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  LatLng toLatLng() {
    return LatLng(lat, lng);
  }

  static Coord fromLatLng(LatLng latLng) {
    if (latLng == null) return null;

    return Coord(
      lat: latLng.latitude,
      lng: latLng.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  static Coord fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coord(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  static Coord fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Coord(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coord && o.lat == lat && o.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
