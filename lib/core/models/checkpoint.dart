import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

class Checkpoint {
  final Place place;
  final String description;
  final DateTime dateTime;

  String get date => DateFormat('MMM dd').format(dateTime);
  String get time => DateFormat('h:mm a').format(dateTime);

  const Checkpoint({
    @required this.place,
    @required this.description,
    @required this.dateTime,
  }) : assert(description != null);

  Checkpoint copyWith({
    Place place,
    String description,
    DateTime dateTime,
  }) {
    return Checkpoint(
      place: place ?? this.place,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place?.toMap(),
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  static Checkpoint fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Checkpoint(
      place: Place.fromMap(map['place']),
      description: map['description'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  static Checkpoint fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Checkpoint &&
        o.place == place &&
        o.description == description &&
        o.dateTime == dateTime;
  }

  @override
  int get hashCode => place.hashCode ^ description.hashCode ^ dateTime.hashCode;

  @override
  String toString() =>
      'Checkpoint(place: $place, description: $description, dateTime: $dateTime)';
}
