import 'package:meta/meta.dart';

import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

class DestinationReviewCubit extends ReviewCubit {
  final Destination destination;

  DestinationReviewCubit({
    @required this.destination,
    @required User user,
    @required ApiService apiService,
  })  : assert(apiService != null),
        assert(destination != null),
        super(user: user, apiService: apiService);

  @override
  bool get hasMore => destination.reviewsList.length < destination.reviewsList.total;

  @override
  Future<bool> loadMore() async {
    page++;
    try {
      final reviewsList = await apiService.fetchReviews(destination.id, page);
      destination.reviewsList.reviews.addAll(reviewsList.reviews);
      emit(ReviewLoaded(
        reviewsList: destination.reviewsList,
        average: destination.rating,
      ));
      return true;
    } on AppError {
      return false;
    }
  }

  @override
  Future<void> fetchReviews() async {
    if (destination.reviewsList.isNotEmpty) {
      emit(ReviewLoaded(
        reviewsList: destination.reviewsList,
        average: destination.rating,
      ));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviewsList = await apiService.fetchReviews(destination.id, 1);
      if (reviewsList.isNotEmpty) {
        destination.reviewsList = reviewsList;
        emit(ReviewLoaded(reviewsList: reviewsList, average: destination.rating));
      } else {
        emit(const ReviewEmpty());
      }
    } on AppError catch (e) {
      emit(ReviewError(message: e.message));
    }
  }

  @override
  Future<bool> postReview(double rating, String text) async {
    if (user == null) return false;

    try {
      final id =
          await apiService.postDestinationReview(rating, text, destination.id, user);
      final review = Review(
        id: id,
        text: text,
        user: user,
        rating: rating,
        dateUpdated: DateTime.now(),
      );

      final updatedList = updateReviewsList(destination.reviewsList, rating, review);
      final oldAverage =
          state is ReviewLoaded ? (state as ReviewLoaded).average : destination.rating;
      final updatedAverage = updateAverage(oldAverage, rating, updatedList.total);
      destination.reviewsList = updatedList;
      emit(ReviewLoaded(reviewsList: updatedList, average: updatedAverage));

      return true;
    } on AppError {
      return false;
    }
  }
}
