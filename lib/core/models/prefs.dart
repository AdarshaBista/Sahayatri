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
  final bool isDarkTheme;

  const Prefs({
    this.contact = '',
    this.deviceName = '',
    this.isDarkTheme = true,
    this.mapStyle = MapStyles.outdoors,
  })  : assert(contact != null),
        assert(mapStyle != null),
        assert(deviceName != null),
        assert(isDarkTheme != null);

  Prefs copyWith({
    String contact,
    String mapStyle,
    bool isDarkTheme,
    String deviceName,
  }) {
    return Prefs(
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
      deviceName: deviceName ?? this.deviceName,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contact': contact,
      'mapStyle': mapStyle,
      'deviceName': deviceName,
      'isDarkTheme': isDarkTheme,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      contact: map['contact'] as String,
      mapStyle: map['mapLayer'] as String,
      deviceName: map['deviceName'] as String,
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }

  @override
  String toString() =>
      'Prefs(contact: $contact, mapStyle: $mapStyle, deviceName: $deviceName, isDarkTheme: $isDarkTheme)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs &&
        o.contact == contact &&
        o.mapStyle == mapStyle &&
        o.deviceName == deviceName &&
        o.isDarkTheme == isDarkTheme;
  }

  @override
  int get hashCode =>
      contact.hashCode ^ mapStyle.hashCode ^ deviceName.hashCode ^ isDarkTheme.hashCode;
}
