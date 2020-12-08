import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/review_details.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'review_state.dart';

abstract class ReviewCubit extends Cubit<ReviewState> {
  final User user;
  final ApiService apiService = locator();

  ReviewCubit({
    @required this.user,
  }) : super(const ReviewEmpty());

  int page = 1;
  bool get hasMore;

  Future<bool> loadMore();
  Future<void> fetchReviews();
  Future<bool> postReview(double rating, String text);

  ReviewDetails updateReviewDetails(ReviewDetails old, double rating, Review review) {
    if (old.isNotEmpty) {
      return old.copyWith(
        total: old.total + 1,
        stars: old.stars..update(rating.ceil(), (value) => ++value),
        reviews: old.reviews..insert(0, review),
      );
    }

    final Map<int, int> stars = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    stars[rating.ceil()] = 1;
    return ReviewDetails(
      total: 1,
      stars: stars,
      reviews: [review],
    );
  }

  double updateAverage(double oldAverage, double rating, int total) {
    return (oldAverage * (total - 1) + rating) / total;
  }
}
