import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'checkpoint.g.dart';

@HiveType(typeId: HiveTypeIds.kCheckpoint)
class Checkpoint {
  @HiveField(0)
  final Place place;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final int day;

  @HiveField(4)
  final bool notifyContact;

  bool get isTemplate => dateTime == null;
  String get date => isTemplate ? 'Day $day' : DateFormat('MMM dd').format(dateTime);
  String get time => isTemplate ? '' : DateFormat('h:mm a').format(dateTime);

  const Checkpoint({
    @required this.place,
    @required this.dateTime,
    @required this.description,
    this.day = 0,
    this.notifyContact = true,
  })  : assert(description != null),
        assert(notifyContact != null);

  Checkpoint copyWith({
    int day,
    Place place,
    String description,
    DateTime dateTime,
    bool notifyContact,
  }) {
    return Checkpoint(
      day: day ?? this.day,
      place: place ?? this.place,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      notifyContact: notifyContact ?? this.notifyContact,
    );
  }

  factory Checkpoint.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Checkpoint(
      day: map['day'] as int,
      description: map['description'] as String,
      place: Place.fromMap(map['place'] as Map<String, dynamic>),
      dateTime: null,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Checkpoint &&
        o.place == place &&
        o.day == day &&
        o.description == description &&
        o.dateTime == dateTime &&
        o.notifyContact == notifyContact;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        day.hashCode ^
        description.hashCode ^
        dateTime.hashCode ^
        notifyContact.hashCode;
  }

  @override
  String toString() {
    return 'Checkpoint(place: $place, day: $day, description: $description, dateTime: $dateTime, notifyContact: $notifyContact)';
  }
}
