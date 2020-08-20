import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/failure.dart';
import 'package:sahayatri/core/models/lodge_review.dart';

import 'package:sahayatri/core/services/api_service.dart';

part 'lodge_review_state.dart';

class LodgeReviewCubit extends Cubit<LodgeReviewState> {
  final User user;
  final Lodge lodge;
  final ApiService apiService;

  LodgeReviewCubit({
    @required this.user,
    @required this.apiService,
    @required this.lodge,
  })  : assert(user != null),
        assert(lodge != null),
        assert(apiService != null),
        super(const LodgeReviewEmpty());

  Future<void> fetchReviews() async {
    if (lodge.reviews != null) {
      emit(LodgeReviewLoaded(reviews: lodge.reviews));
      return;
    }

    emit(const LodgeReviewLoading());
    try {
      final reviews = await apiService.fetchLodgeReviews(lodge.id, user);
      if (reviews.isNotEmpty) {
        lodge.reviews = reviews;
        emit(LodgeReviewLoaded(reviews: reviews));
      } else {
        emit(const LodgeReviewEmpty());
      }
    } on Failure catch (e) {
      emit(LodgeReviewError(message: e.message));
    }
  }

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
        LodgeReview(id: id, text: text, user: user, rating: rating),
      );
      emit(LodgeReviewLoaded(reviews: lodge.reviews));
      return true;
    } on Failure {
      return false;
    }
  }
}
