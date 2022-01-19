import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/constants/hive_config.dart';

part 'review_details.g.dart';

@HiveType(typeId: HiveTypeIds.reviewDetails)
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
  });

  ReviewDetails copyWith({
    int? total,
    Map<int, int>? stars,
    List<Review>? reviews,
  }) {
    return ReviewDetails(
      total: total ?? this.total,
      stars: stars ?? this.stars,
      reviews: reviews ?? this.reviews,
    );
  }

  factory ReviewDetails.fromMap(Map<String, dynamic> map) {
    return ReviewDetails(
      total: map['count'] ?? 0,
      stars: Map<int, int>.from((map['stars']?.map((key, value) => MapEntry(
            int.tryParse(key) ?? 0,
            int.tryParse(value) ?? 0,
          )))),
      reviews: List<Review>.from((map['data']?.map((x) => Review.fromMap(x)))),
    );
  }

  @override
  String toString() =>
      'ReviewDetails(total: $total, stars: $stars, reviews: $reviews)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewDetails &&
        other.total == total &&
        mapEquals(other.stars, stars) &&
        listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode => total.hashCode ^ stars.hashCode ^ reviews.hashCode;
}
