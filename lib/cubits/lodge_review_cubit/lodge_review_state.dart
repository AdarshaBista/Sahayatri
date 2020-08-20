part of 'lodge_review_cubit.dart';

abstract class LodgeReviewState {
  const LodgeReviewState();
}

class LodgeReviewEmpty extends LodgeReviewState {
  const LodgeReviewEmpty();
}

class LodgeReviewLoading extends LodgeReviewState {
  const LodgeReviewLoading();
}

class LodgeReviewLoaded extends LodgeReviewState {
  final List<LodgeReview> reviews;

  const LodgeReviewLoaded({
    @required this.reviews,
  }) : assert(reviews != null);
}

class LodgeReviewError extends LodgeReviewState {
  final String message;

  const LodgeReviewError({
    @required this.message,
  }) : assert(message != null);
}
