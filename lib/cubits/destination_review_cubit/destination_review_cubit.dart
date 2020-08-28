import 'package:meta/meta.dart';

import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/failure.dart';
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
  Future<void> fetchReviews() async {
    if (destination.reviews != null) {
      emit(ReviewLoaded(reviews: destination.reviews));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviews = await apiService.fetchReviews(destination.id);
      if (reviews.isNotEmpty) {
        destination.reviews = reviews;
        emit(ReviewLoaded(reviews: reviews));
      } else {
        emit(const ReviewEmpty());
      }
    } on Failure catch (e) {
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
        user,
      );
      destination.reviews.insert(
        0,
        Review(
          id: id,
          text: text,
          user: user,
          rating: rating,
          dateUpdated: DateTime.now(),
        ),
      );
      emit(ReviewLoaded(reviews: destination.reviews));
      return true;
    } on Failure {
      return false;
    }
  }
}
