import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/reviews_list.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'review_state.dart';

abstract class ReviewCubit extends Cubit<ReviewState> {
  final User user;
  final ApiService apiService;

  ReviewCubit({
    @required this.user,
    @required this.apiService,
  })  : assert(apiService != null),
        super(const ReviewEmpty());

  Future<void> fetchReviews();
  Future<bool> postReview(double rating, String text);

  ReviewsList updateReviewsList(ReviewsList old, double rating, Review review) {
    return old.copyWith(
      total: old.total + 1,
      stars: old.stars..update(rating.ceil(), (value) => ++value),
      reviews: old.reviews..insert(0, review),
    );
  }

  double updateAverage(double oldAverage, double rating, int total) {
    return oldAverage + (rating - oldAverage) / total;
  }
}
