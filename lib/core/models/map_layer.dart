import 'package:flutter/material.dart';

class MapLayer {
  final String id;
  final String title;
  final IconData icon;

  const MapLayer({
    @required this.id,
    @required this.title,
    @required this.icon,
  })  : assert(id != null),
        assert(icon != null),
        assert(title != null);

  MapLayer copyWith({
    String id,
    String title,
    IconData icon,
  }) {
    return MapLayer(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon?.codePoint,
    };
  }

  factory MapLayer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MapLayer(
      id: map['id'] as String,
      title: map['title'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'CommunityMaterialIcons'),
    );
  }

  @override
  String toString() => 'MapLayer(if: $id, title: $title, icon: $icon)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MapLayer && o.id == id && o.title == title && o.icon == icon;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ icon.hashCode;
}
