import 'package:meta/meta.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/user.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'review.g.dart';

@HiveType(typeId: HiveTypeIds.kReview)
class Review {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final User user;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final double rating;

  const Review({
    @required this.id,
    @required this.user,
    @required this.text,
    @required this.rating,
  })  : assert(id != null),
        assert(user != null),
        assert(text != null),
        assert(rating != null);

  Review copyWith({
    String id,
    User user,
    String text,
    double rating,
  }) {
    return Review(
      id: id ?? this.id,
      user: user ?? this.user,
      text: text ?? this.text,
      rating: rating ?? this.rating,
    );
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Review(
      id: map['id'] as String,
      text: map['text'] as String,
      rating: double.tryParse(map['rating'] as String) ?? 0.0,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'Review(id: $id, user: $user, text: $text, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Review &&
        o.id == id &&
        o.user == user &&
        o.text == text &&
        o.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ text.hashCode ^ rating.hashCode;
  }
}
