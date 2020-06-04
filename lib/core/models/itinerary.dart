import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

class Itinerary {
  final String name;
  final String days;
  final String nights;
  final List<Checkpoint> checkpoints;

  const Itinerary({
    @required this.name,
    @required this.days,
    @required this.nights,
    @required this.checkpoints,
  })  : assert(name != null),
        assert(days != null),
        assert(nights != null),
        assert(checkpoints != null);

  Itinerary copyWith({
    String name,
    String days,
    String nights,
    List<Checkpoint> checkpoints,
  }) {
    return Itinerary(
      name: name ?? this.name,
      days: days ?? this.days,
      nights: nights ?? this.nights,
      checkpoints: checkpoints ?? this.checkpoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'days': days,
      'nights': nights,
      'checkpoints': checkpoints?.map((x) => x?.toMap())?.toList(),
    };
  }

  static Itinerary fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Itinerary(
      name: map['name'],
      days: map['days'],
      nights: map['nights'],
      checkpoints: List<Checkpoint>.from(
          map['checkpoints']?.map((x) => Checkpoint.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Itinerary fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Itinerary(name: $name, days: $days, nights: $nights, checkpoints: $checkpoints)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Itinerary &&
        o.name == name &&
        o.days == days &&
        o.nights == nights &&
        listEquals(o.checkpoints, checkpoints);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        days.hashCode ^
        nights.hashCode ^
        checkpoints.hashCode;
  }
}
