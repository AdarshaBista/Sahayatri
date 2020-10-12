import 'package:meta/meta.dart';

import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/app_error.dart';

import 'package:sahayatri/core/services/api_service.dart';

class LodgeReviewCubit extends ReviewCubit {
  final Lodge lodge;

  LodgeReviewCubit({
    @required this.lodge,
    @required User user,
    @required ApiService apiService,
  })  : assert(user != null),
        assert(lodge != null),
        assert(apiService != null),
        super(user: user, apiService: apiService);

  @override
  bool get hasMore => lodge.reviewDetails.length < lodge.reviewDetails.total;

  @override
  Future<bool> loadMore() async {
    page++;
    try {
      final reviewDetails = await apiService.fetchLodgeReviews(lodge.id, page, user);
      lodge.reviewDetails.reviews.addAll(reviewDetails.reviews);
      emit(ReviewLoaded(reviewDetails: lodge.reviewDetails, average: lodge.rating));
      return true;
    } on AppError {
      return false;
    }
  }

  @override
  Future<void> fetchReviews() async {
    if (lodge.reviewDetails.isNotEmpty) {
      emit(ReviewLoaded(reviewDetails: lodge.reviewDetails, average: lodge.rating));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviewDetails = await apiService.fetchLodgeReviews(lodge.id, 1, user);
      if (reviewDetails.isNotEmpty) {
        lodge.reviewDetails = reviewDetails;
        emit(ReviewLoaded(reviewDetails: reviewDetails, average: lodge.rating));
      } else {
        emit(const ReviewEmpty());
      }
    } on AppError catch (e) {
      emit(ReviewError(message: e.message));
    }
  }

  @override
  Future<bool> postReview(double rating, String text) async {
    try {
      final id = await apiService.postLodgeReview(rating, text, lodge.id, user);
      final review = Review(
        id: id,
        text: text,
        user: user,
        rating: rating,
        dateUpdated: DateTime.now(),
      );

      final updatedList = updatereviewDetails(lodge.reviewDetails, rating, review);
      final oldAverage =
          state is ReviewLoaded ? (state as ReviewLoaded).average : lodge.rating;
      final updatedAverage = updateAverage(oldAverage, rating, updatedList.total);
      lodge.reviewDetails = updatedList;
      emit(ReviewLoaded(reviewDetails: updatedList, average: updatedAverage));

      return true;
    } on AppError {
      return false;
    }
  }
}
