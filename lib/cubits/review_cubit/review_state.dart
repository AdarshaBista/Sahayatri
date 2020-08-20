part of 'review_cubit.dart';

abstract class ReviewState {
  const ReviewState();
}

class ReviewEmpty extends ReviewState {
  const ReviewEmpty();
}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewLoaded({
    @required this.reviews,
  }) : assert(reviews != null);
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({
    @required this.message,
  }) : assert(message != null);
}
