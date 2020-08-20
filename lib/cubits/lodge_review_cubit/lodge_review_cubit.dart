import 'package:meta/meta.dart';

import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/failure.dart';

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
  Future<void> fetchReviews() async {
    if (lodge.reviews != null) {
      emit(ReviewLoaded(reviews: lodge.reviews));
      return;
    }

    emit(const ReviewLoading());
    try {
      final reviews = await apiService.fetchLodgeReviews(lodge.id, user);
      if (reviews.isNotEmpty) {
        lodge.reviews = reviews;
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
    try {
      final id = await apiService.postLodgeReview(
        rating,
        text,
        lodge.id,
        user,
      );
      lodge.reviews.insert(
        0,
        Review(id: id, text: text, user: user, rating: rating),
      );
      emit(ReviewLoaded(reviews: lodge.reviews));
      return true;
    } on Failure {
      return false;
    }
  }
}
