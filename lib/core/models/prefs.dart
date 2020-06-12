import 'package:sahayatri/app/constants/values.dart';

class Prefs {
  String mapStyle;

  Prefs({
    this.mapStyle = Values.kMapStyleOutdoors,
  }) : assert(mapStyle != null);

  Prefs copyWith({
    String mapStyle,
  }) {
    return Prefs(
      mapStyle: mapStyle ?? this.mapStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mapLayer': mapStyle,
    };
  }

  factory Prefs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Prefs(
      mapStyle: map['mapLayer'] as String,
    );
  }

  @override
  String toString() => 'Prefs(mapLayer: $mapStyle)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Prefs && o.mapStyle == mapStyle;
  }

  @override
  int get hashCode => mapStyle.hashCode;
}
