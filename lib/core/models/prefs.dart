import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/map_layers.dart';
import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

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

  @HiveField(5)
  final String gpsAccuracy;

  const Prefs({
    this.contact = '',
    this.deviceName = '',
    this.theme = ThemeStyles.system,
    this.mapStyle = MapStyles.outdoors,
    this.mapLayers = const MapLayers(),
    this.gpsAccuracy = GpsAccuracy.high,
  });

  Prefs copyWith({
    String? theme,
    String? contact,
    String? mapStyle,
    String? deviceName,
    String? gpsAccuracy,
    MapLayers? mapLayers,
  }) {
    return Prefs(
      theme: theme ?? this.theme,
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
      mapLayers: mapLayers ?? this.mapLayers,
      deviceName: deviceName ?? this.deviceName,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
    );
  }

  @override
  String toString() {
    return 'Prefs(contact: $contact, mapStyle: $mapStyle, deviceName: $deviceName, theme: $theme, mapLayers: $mapLayers, gpsAccuracy: $gpsAccuracy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Prefs &&
        other.contact == contact &&
        other.mapStyle == mapStyle &&
        other.deviceName == deviceName &&
        other.theme == theme &&
        other.mapLayers == mapLayers &&
        other.gpsAccuracy == gpsAccuracy;
  }

  @override
  int get hashCode {
    return contact.hashCode ^
        mapStyle.hashCode ^
        deviceName.hashCode ^
        theme.hashCode ^
        mapLayers.hashCode ^
        gpsAccuracy.hashCode;
  }
}
