import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';

part 'map_layers.g.dart';

@HiveType(typeId: HiveTypeIds.mapLayers)
class MapLayers {
  @HiveField(0)
  final bool route;

  @HiveField(1)
  final bool places;

  @HiveField(2)
  final bool checkpoints;

  @HiveField(3)
  final bool nearbyDevices;

  const MapLayers({
    this.route = true,
    this.places = true,
    this.checkpoints = true,
    this.nearbyDevices = true,
  })  : assert(route != null),
        assert(places != null),
        assert(checkpoints != null),
        assert(nearbyDevices != null);

  MapLayers copyWith({
    bool route,
    bool flags,
    bool places,
    bool checkpoints,
    bool nearbyDevices,
  }) {
    return MapLayers(
      route: route ?? this.route,
      places: places ?? this.places,
      checkpoints: checkpoints ?? this.checkpoints,
      nearbyDevices: nearbyDevices ?? this.nearbyDevices,
    );
  }

  @override
  String toString() {
    return 'MapLayers(route: $route, places: $places, checkpoints: $checkpoints, nearbyDevices: $nearbyDevices)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MapLayers &&
        o.route == route &&
        o.places == places &&
        o.checkpoints == checkpoints &&
        o.nearbyDevices == nearbyDevices;
  }

  @override
  int get hashCode {
    return route.hashCode ^
        places.hashCode ^
        checkpoints.hashCode ^
        nearbyDevices.hashCode;
  }
}
