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
  bool get hasMore => lodge.reviewsList.length < lodge.reviewsList.total;

  @override
  Future<bool> loadMore() async {
    page++;
    try {
      final reviewsList = await apiService.fetchLodgeReviews(lodge.id, page, user);
      lodge.reviewsList.reviews.addAll(reviewsList.reviews);
      emit(ReviewLoaded(reviewsList: lodge.reviewsList, average: lodge.rating));
      return true;
    } on AppError {
      return false;
    }
  }

  @override
  Future<void> fetchReviews() async {
    if (lodge.reviewsList.isNotEmpty) {
      emit(ReviewLoaded(reviewsList: lodge.reviewsList, average: lodge.rating));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviewsList = await apiService.fetchLodgeReviews(lodge.id, 1, user);
      if (reviewsList.isNotEmpty) {
        lodge.reviewsList = reviewsList;
        emit(ReviewLoaded(reviewsList: reviewsList, average: lodge.rating));
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

      final updatedList = updateReviewsList(lodge.reviewsList, rating, review);
      final oldAverage =
          state is ReviewLoaded ? (state as ReviewLoaded).average : lodge.rating;
      final updatedAverage = updateAverage(oldAverage, rating, updatedList.total);
      lodge.reviewsList = updatedList;
      emit(ReviewLoaded(reviewsList: updatedList, average: updatedAverage));

      return true;
    } on AppError {
      return false;
    }
  }
}
