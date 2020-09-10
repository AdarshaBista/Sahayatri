import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'reviews_list.g.dart';

@HiveType(typeId: HiveTypeIds.kReviewsList)
class ReviewsList {
  @HiveField(0)
  final int total;

  @HiveField(1)
  final Map<int, int> stars;

  @HiveField(2)
  final List<Review> reviews;

  bool get isNotEmpty => reviews.isNotEmpty;

  const ReviewsList({
    this.total = 0,
    this.stars = const {},
    this.reviews = const [],
  })  : assert(total != null),
        assert(stars != null),
        assert(reviews != null);

  ReviewsList copyWith({
    int total,
    List<Review> reviews,
    Map<int, int> stars,
  }) {
    return ReviewsList(
      total: total ?? this.total,
      stars: stars ?? this.stars,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ReviewsList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReviewsList(
      total: map['count'] as int,
      stars: Map<int, int>.from(
          (map['stars'] as Map<String, dynamic>).map((key, value) => MapEntry(
                int.tryParse(key) ?? 0,
                int.tryParse(value as String) ?? 0,
              ))),
      reviews: List<Review>.from((map['data'] as List<dynamic>)
          ?.map((x) => Review.fromMap(x as Map<String, dynamic>))),
    );
  }

  @override
  String toString() => 'ReviewsList(total: $total, stars: $stars, reviews: $reviews)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReviewsList &&
        o.total == total &&
        mapEquals(o.stars, stars) &&
        listEquals(o.reviews, reviews);
  }

  @override
  int get hashCode => total.hashCode ^ stars.hashCode ^ reviews.hashCode;
}
