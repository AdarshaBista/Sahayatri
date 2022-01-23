import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/destination.dart';

class DestinationReviewCubit extends ReviewCubit {
  final Destination destination;

  DestinationReviewCubit({
    required this.destination,
    required User? user,
  }) : super(user: user);

  @override
  bool get hasMore =>
      destination.reviewDetails.length < destination.reviewDetails.total;

  @override
  Future<bool> loadMore() async {
    page++;
    try {
      final reviewDetails = await apiService.fetchReviews(destination.id, page);
      destination.reviewDetails.reviews.addAll(reviewDetails.reviews);
      emit(ReviewLoaded(
        reviewDetails: destination.reviewDetails,
        average: destination.rating,
      ));
      return true;
    } on AppError {
      return false;
    }
  }

  @override
  Future<void> fetchReviews() async {
    if (destination.reviewDetails.isNotEmpty) {
      emit(ReviewLoaded(
        reviewDetails: destination.reviewDetails,
        average: destination.rating,
      ));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviewDetails = await apiService.fetchReviews(destination.id, 1);
      if (reviewDetails.isNotEmpty) {
        destination.reviewDetails = reviewDetails;
        emit(ReviewLoaded(
            reviewDetails: reviewDetails, average: destination.rating));
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
      final id = await apiService.postDestinationReview(
        rating,
        text,
        destination.id,
        user!,
      );
      final review = Review(
        id: id,
        text: text,
        user: user!,
        rating: rating,
        dateUpdated: DateTime.now(),
      );

      final updatedList =
          updateReviewDetails(destination.reviewDetails, rating, review);
      final oldAverage = state is ReviewLoaded
          ? (state as ReviewLoaded).average
          : destination.rating;
      final updatedAverage =
          updateAverage(oldAverage, rating, updatedList.total);
      destination.reviewDetails = updatedList;
      emit(ReviewLoaded(reviewDetails: updatedList, average: updatedAverage));

      return true;
    } on AppError {
      return false;
    }
  }
}
