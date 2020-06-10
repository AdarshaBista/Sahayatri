import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/map_layer.dart';

class Prefs {
  MapLayer mapLayer;

  Prefs({
    @required this.mapLayer,
  });

  Prefs copyWith({
    MapLayer mapLayer,
  }) {
    return Prefs(
      mapLayer: mapLayer ?? this.mapLayer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mapLayer': mapLayer?.toMap(),
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      mapLayer: MapLayer.fromMap(map['mapLayer'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() => 'Prefs(mapLayer: $mapLayer)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs && o.mapLayer == mapLayer;
  }

  @override
  int get hashCode => mapLayer.hashCode;
}
