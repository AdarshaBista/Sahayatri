import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:sahayatri/core/models/place.dart';

class Checkpoint {
  final Place place;
  final String description;
  final DateTime dateTime;
  final int day;

  bool get isTemplate => dateTime == null;

  String get date =>
      isTemplate ? 'Day $day' : DateFormat('MMM dd').format(dateTime);
  String get time => isTemplate ? '' : DateFormat('h:mm a').format(dateTime);

  const Checkpoint({
    @required this.place,
    @required this.description,
    @required this.dateTime,
    this.day = 0,
  }) : assert(description != null);

  Checkpoint copyWith({
    Place place,
    int day,
    String description,
    DateTime dateTime,
  }) {
    return Checkpoint(
      place: place ?? this.place,
      day: day ?? this.day,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place?.toMap(),
      'day': day,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory Checkpoint.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Checkpoint(
      place: Place.fromMap(map['place'] as Map<String, dynamic>),
      day: map['day'] as int,
      description: map['description'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Checkpoint &&
        o.place == place &&
        o.day == day &&
        o.description == description &&
        o.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        day.hashCode ^
        description.hashCode ^
        dateTime.hashCode;
  }

  @override
  String toString() {
    return 'Checkpoint(place: $place, day: $day, description: $description, dateTime: $dateTime)';
  }
}
