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
  });

  MapLayers copyWith({
    bool? route,
    bool? flags,
    bool? places,
    bool? checkpoints,
    bool? nearbyDevices,
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapLayers &&
        other.route == route &&
        other.places == places &&
        other.checkpoints == checkpoints &&
        other.nearbyDevices == nearbyDevices;
  }

  @override
  int get hashCode {
    return route.hashCode ^
        places.hashCode ^
        checkpoints.hashCode ^
        nearbyDevices.hashCode;
  }
}
