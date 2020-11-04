import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'itinerary.g.dart';

@HiveType(typeId: HiveTypeIds.itinerary)
class Itinerary {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String days;

  @HiveField(2)
  final String nights;

  @HiveField(3)
  final List<Checkpoint> checkpoints;

  bool get isTemplate => checkpoints.any((c) => c.isTemplate);

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

  factory Itinerary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Itinerary(
      name: map['name'] as String,
      days: map['days'] as String,
      nights: map['nights'] as String,
      checkpoints: List<Checkpoint>.from((map['checkpoints'] as List<dynamic>)
          ?.map((x) => Checkpoint.fromMap(x as Map<String, dynamic>)))
        ..sort((c1, c2) => c1.day.compareTo(c2.day)),
    );
  }

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
    return name.hashCode ^ days.hashCode ^ nights.hashCode ^ checkpoints.hashCode;
  }
}
