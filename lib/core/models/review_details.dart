import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/app/constants/hive_config.dart';

part 'review_details.g.dart';

@HiveType(typeId: HiveTypeIds.kReviewDetails)
class ReviewDetails {
  @HiveField(0)
  final int total;

  @HiveField(1)
  final Map<int, int> stars;

  @HiveField(2)
  final List<Review> reviews;

  int get length => reviews.length;
  bool get isNotEmpty => reviews.isNotEmpty;

  const ReviewDetails({
    this.total = 0,
    this.stars = const {},
    this.reviews = const [],
  })  : assert(total != null),
        assert(stars != null),
        assert(reviews != null);

  ReviewDetails copyWith({
    int total,
    Map<int, int> stars,
    List<Review> reviews,
  }) {
    return ReviewDetails(
      total: total ?? this.total,
      stars: stars ?? this.stars,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ReviewDetails.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReviewDetails(
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
  String toString() => 'ReviewDetails(total: $total, stars: $stars, reviews: $reviews)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReviewDetails &&
        o.total == total &&
        mapEquals(o.stars, stars) &&
        listEquals(o.reviews, reviews);
  }

  @override
  int get hashCode => total.hashCode ^ stars.hashCode ^ reviews.hashCode;
}
