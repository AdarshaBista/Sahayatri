import 'package:flutter/material.dart';

class MapLayer {
  final String title;
  final String value;
  final IconData icon;

  const MapLayer({
    @required this.icon,
    @required this.title,
    @required this.value,
  })  : assert(icon != null),
        assert(title != null),
        assert(value != null);

  MapLayer copyWith({
    String title,
    String value,
    IconData icon,
  }) {
    return MapLayer(
      title: title ?? this.title,
      value: value ?? this.value,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() => 'MapLayer(title: $title, value: $value, icon: $icon)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MapLayer && o.title == title && o.value == value && o.icon == icon;
  }

  @override
  int get hashCode => title.hashCode ^ value.hashCode ^ icon.hashCode;
}
