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
