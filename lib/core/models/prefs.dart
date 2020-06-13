import 'package:hive/hive.dart';

import 'package:sahayatri/app/constants/values.dart';

part 'prefs.g.dart';

@HiveType(typeId: 0)
class Prefs {
  @HiveField(0)
  final String contact;

  @HiveField(1)
  final String mapStyle;

  const Prefs({
    this.contact = '',
    this.mapStyle = Values.kMapStyleOutdoors,
  })  : assert(contact != null),
        assert(mapStyle != null);

  Prefs copyWith({
    String contact,
    String mapStyle,
  }) {
    return Prefs(
      contact: contact ?? this.contact,
      mapStyle: mapStyle ?? this.mapStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contact': contact,
      'mapStyle': mapStyle,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      contact: map['contact'] as String,
      mapStyle: map['mapLayer'] as String,
    );
  }

  @override
  String toString() => 'Prefs(contact: $contact, mapStyle: $mapStyle)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs && o.contact == contact && o.mapStyle == mapStyle;
  }

  @override
  int get hashCode => contact.hashCode ^ mapStyle.hashCode;
}
