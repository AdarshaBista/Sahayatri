import 'package:meta/meta.dart';

import 'package:sahayatri/core/models/user.dart';

class Review {
  final int id;
  final User user;
  final String text;
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
    int id,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user?.toMap(),
      'text': text,
      'rating': rating,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Review(
      id: map['id'] as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      text: map['text'] as String,
      rating: map['rating'] as double,
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
