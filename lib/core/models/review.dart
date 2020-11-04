import 'package:meta/meta.dart';

import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'review.g.dart';

@HiveType(typeId: HiveTypeIds.review)
class Review {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final User user;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final DateTime dateUpdated;

  String get date => DateFormat('MM/dd/yyyy').format(dateUpdated);

  const Review({
    @required this.id,
    @required this.user,
    @required this.text,
    @required this.rating,
    @required this.dateUpdated,
  })  : assert(id != null),
        assert(user != null),
        assert(text != null),
        assert(rating != null),
        assert(dateUpdated != null);

  Review copyWith({
    String id,
    User user,
    String text,
    double rating,
    DateTime dateUpdated,
  }) {
    return Review(
      id: id ?? this.id,
      user: user ?? this.user,
      text: text ?? this.text,
      rating: rating ?? this.rating,
      dateUpdated: dateUpdated ?? this.dateUpdated,
    );
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Review(
      id: map['id'] as String,
      text: map['text'] as String,
      rating: double.tryParse(map['rating'] as String) ?? 0.0,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      dateUpdated: DateTime.tryParse(map['dateupdated'] as String) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, user: $user, text: $text, rating: $rating, dateUpdated: $dateUpdated)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Review &&
        o.id == id &&
        o.user == user &&
        o.text == text &&
        o.rating == rating &&
        o.dateUpdated == dateUpdated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        text.hashCode ^
        rating.hashCode ^
        dateUpdated.hashCode;
  }
}
