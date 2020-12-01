import 'package:hive/hive.dart';

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

  const Prefs({
    this.contact = '',
    this.deviceName = '',
    this.theme = 'system',
    this.mapStyle = MapStyles.outdoors,
  })  : assert(theme != null),
        assert(contact != null),
        assert(mapStyle != null),
        assert(deviceName != null);

  Prefs copyWith({
    String theme,
    String contact,
    String mapStyle,
    String deviceName,
  }) {
    return Prefs(
      theme: theme ?? this.theme,
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
      deviceName: deviceName ?? this.deviceName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'contact': contact,
      'mapStyle': mapStyle,
      'deviceName': deviceName,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      theme: map['theme'] as String,
      contact: map['contact'] as String,
      mapStyle: map['mapLayer'] as String,
      deviceName: map['deviceName'] as String,
    );
  }

  @override
  String toString() =>
      'Prefs(contact: $contact, mapStyle: $mapStyle, deviceName: $deviceName, theme: $theme)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs &&
        o.contact == contact &&
        o.mapStyle == mapStyle &&
        o.deviceName == deviceName &&
        o.theme == theme;
  }

  @override
  int get hashCode =>
      contact.hashCode ^ mapStyle.hashCode ^ deviceName.hashCode ^ theme.hashCode;
}
