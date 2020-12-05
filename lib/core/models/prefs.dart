import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/map_layers.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/constants/hive_config.dart';

part 'prefs.g.dart';

@HiveType(typeId: HiveTypeIds.prefs)
class Prefs {
  @HiveField(0)
  final String contact;

  @HiveField(1)
  final String mapStyle;

  @HiveField(2)
  final String deviceName;

  @HiveField(3)
  final String theme;

  @HiveField(4)
  final MapLayers mapLayers;

  const Prefs({
    this.contact = '',
    this.deviceName = '',
    this.theme = 'system',
    this.mapStyle = MapStyles.outdoors,
    this.mapLayers = const MapLayers(),
  })  : assert(theme != null),
        assert(contact != null),
        assert(mapStyle != null),
        assert(mapLayers != null),
        assert(deviceName != null);

  Prefs copyWith({
    String theme,
    String contact,
    String mapStyle,
    String deviceName,
    MapLayers mapLayers,
  }) {
    return Prefs(
      theme: theme ?? this.theme,
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
      mapLayers: mapLayers ?? this.mapLayers,
      deviceName: deviceName ?? this.deviceName,
    );
  }

  @override
  String toString() {
    return 'Prefs(contact: $contact, mapStyle: $mapStyle, deviceName: $deviceName, theme: $theme, mapLayers: $mapLayers)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs &&
        o.contact == contact &&
        o.mapStyle == mapStyle &&
        o.deviceName == deviceName &&
        o.theme == theme &&
        o.mapLayers == mapLayers;
  }

  @override
  int get hashCode {
    return contact.hashCode ^
        mapStyle.hashCode ^
        deviceName.hashCode ^
        theme.hashCode ^
        mapLayers.hashCode;
  }
}
