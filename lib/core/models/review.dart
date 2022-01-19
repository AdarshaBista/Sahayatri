import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:sahayatri/core/constants/hive_config.dart';
import 'package:sahayatri/core/models/user.dart';

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
    required this.id,
    required this.user,
    required this.text,
    required this.rating,
    required this.dateUpdated,
  });

  Review copyWith({
    String? id,
    User? user,
    String? text,
    double? rating,
    DateTime? dateUpdated,
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
    return Review(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      user: User.fromMap(map['user']),
      rating: map['rating']?.toDouble() ?? 0.0,
      dateUpdated: DateTime.tryParse(map['dateupdated'] as String) ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, user: $user, text: $text, rating: $rating, dateUpdated: $dateUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.id == id &&
        other.user == user &&
        other.text == text &&
        other.rating == rating &&
        other.dateUpdated == dateUpdated;
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
