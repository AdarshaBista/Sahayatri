import 'package:hive/hive.dart';

import 'package:sahayatri/app/constants/resources.dart';

part 'prefs.g.dart';

@HiveType(typeId: 0)
class Prefs {
  @HiveField(0)
  final String contact;

  @HiveField(1)
  final String mapStyle;

  @HiveField(2)
  final String deviceName;

  const Prefs({
    this.contact = '',
    this.mapStyle = MapStyles.kOutdoors,
    this.deviceName = '',
  })  : assert(contact != null),
        assert(mapStyle != null),
        assert(deviceName != null);

  Prefs copyWith({
    String contact,
    String mapStyle,
    String deviceName,
  }) {
    return Prefs(
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
      deviceName: deviceName ?? this.deviceName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contact': contact,
      'mapStyle': mapStyle,
      'deviceName': deviceName,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      contact: map['contact'] as String,
      mapStyle: map['mapLayer'] as String,
      deviceName: map['deviceName'] as String,
    );
  }

  @override
  String toString() =>
      'Prefs(contact: $contact, mapStyle: $mapStyle, deviceName: $deviceName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs &&
        o.contact == contact &&
        o.mapStyle == mapStyle &&
        o.deviceName == deviceName;
  }

  @override
  int get hashCode => contact.hashCode ^ mapStyle.hashCode ^ deviceName.hashCode;
}
