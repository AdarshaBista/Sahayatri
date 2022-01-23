import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/place.dart';

part 'checkpoint.g.dart';

@HiveType(typeId: HiveTypeIds.checkpoint)
class Checkpoint {
  @HiveField(0)
  final Place? place;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime? dateTime;

  @HiveField(3)
  final int day;

  @HiveField(4)
  final bool notifyContact;

  bool get isTemplate => dateTime == null;
  String get time => isTemplate ? '' : DateFormat('h:mm a').format(dateTime!);
  String get date =>
      isTemplate ? 'Day $day' : DateFormat('MMM dd').format(dateTime!);

  const Checkpoint({
    required this.place,
    required this.description,
    required this.dateTime,
    this.day = 0,
    this.notifyContact = true,
  });

  Checkpoint copyWith({
    Place? place,
    String? description,
    DateTime? dateTime,
    int? day,
    bool? notifyContact,
  }) {
    return Checkpoint(
      place: place ?? this.place,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      day: day ?? this.day,
      notifyContact: notifyContact ?? this.notifyContact,
    );
  }

  factory Checkpoint.fromMap(Map<String, dynamic> map) {
    return Checkpoint(
      place: Place.fromMap(map['place']),
      description: map['description'] ?? '',
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'])
          : null,
      day: map['day']?.toInt() ?? 0,
      notifyContact: map['notifyContact'] ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Checkpoint &&
        other.place == place &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.day == day &&
        other.notifyContact == notifyContact;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        description.hashCode ^
        dateTime.hashCode ^
        day.hashCode ^
        notifyContact.hashCode;
  }

  @override
  String toString() {
    return 'Checkpoint(place: $place, description: $description, dateTime: $dateTime, day: $day, notifyContact: $notifyContact)';
  }
}
