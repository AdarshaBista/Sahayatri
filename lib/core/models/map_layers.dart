import 'package:hive/hive.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'map_layers.g.dart';

@HiveType(typeId: HiveTypeIds.mapLayers)
class MapLayers {
  @HiveField(0)
  final bool route;

  @HiveField(1)
  final bool flags;

  @HiveField(2)
  final bool places;

  @HiveField(3)
  final bool checkpoints;

  @HiveField(4)
  final bool nearbyDevices;

  const MapLayers({
    this.route = true,
    this.flags = true,
    this.places = true,
    this.checkpoints = true,
    this.nearbyDevices = true,
  })  : assert(route != null),
        assert(flags != null),
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
      flags: flags ?? this.flags,
      places: places ?? this.places,
      checkpoints: checkpoints ?? this.checkpoints,
      nearbyDevices: nearbyDevices ?? this.nearbyDevices,
    );
  }

  @override
  String toString() {
    return 'MapLayers(route: $route, flags: $flags, places: $places, checkpoints: $checkpoints, nearbyDevices: $nearbyDevices)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MapLayers &&
        o.route == route &&
        o.flags == flags &&
        o.places == places &&
        o.checkpoints == checkpoints &&
        o.nearbyDevices == nearbyDevices;
  }

  @override
  int get hashCode {
    return route.hashCode ^
        flags.hashCode ^
        places.hashCode ^
        checkpoints.hashCode ^
        nearbyDevices.hashCode;
  }
}
