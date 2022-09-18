import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/checkpoint.dart';

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
    required this.name,
    required this.days,
    required this.nights,
    required this.checkpoints,
  });

  Itinerary copyWith({
    String? name,
    String? days,
    String? nights,
    List<Checkpoint>? checkpoints,
  }) {
    return Itinerary(
      name: name ?? this.name,
      days: days ?? this.days,
      nights: nights ?? this.nights,
      checkpoints: checkpoints ?? this.checkpoints,
    );
  }

  factory Itinerary.fromMap(Map<String, dynamic> map) {
    return Itinerary(
      name: map['name'] ?? '',
      days: map['days'] ?? '',
      nights: map['nights'] ?? '',
      checkpoints: List<Checkpoint>.from(
          map['checkpoints']?.map((x) => Checkpoint.fromMap(x as Map<String, dynamic>)))
        ..sort((c1, c2) => c1.day.compareTo(c2.day)),
    );
  }

  @override
  String toString() {
    return 'Itinerary(name: $name, days: $days, nights: $nights, checkpoints: $checkpoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Itinerary &&
        other.name == name &&
        other.days == days &&
        other.nights == nights &&
        listEquals(other.checkpoints, checkpoints);
  }

  @override
  int get hashCode {
    return name.hashCode ^ days.hashCode ^ nights.hashCode ^ checkpoints.hashCode;
  }
}
