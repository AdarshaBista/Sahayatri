import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'destination_review_state.dart';

class DestinationReviewCubit extends Cubit<DestinationReviewState> {
  final User user;
  final ApiService apiService;
  final Destination destination;

  DestinationReviewCubit({
    @required this.user,
    @required this.apiService,
    @required this.destination,
  })  : assert(user != null),
        assert(apiService != null),
        assert(destination != null),
        super(const DestinationReviewEmpty());

  Future<void> fetchReviews() async {
    if (destination.reviews != null) {
      emit(DestinationReviewLoaded(reviews: destination.reviews));
      return;
    }

    emit(const DestinationReviewLoading());
    try {
      final reviews = await apiService.fetchReviews(destination.id);
      if (reviews.isNotEmpty) {
        destination.reviews = reviews;
        emit(DestinationReviewLoaded(reviews: reviews));
      } else {
        emit(const DestinationReviewEmpty());
      }
    } on Failure catch (e) {
      emit(DestinationReviewError(message: e.message));
    }
  }

  Future<bool> postReview(double rating, String text) async {
    try {
      final id = await apiService.postDestinationReview(
        rating,
        text,
        destination.id,
        user,
      );
      destination.reviews.insert(
        0,
        Review(id: id, text: text, user: user, rating: rating),
      );
      emit(DestinationReviewLoaded(reviews: destination.reviews));
      return true;
    } on Failure {
      return false;
    }
  }
}
