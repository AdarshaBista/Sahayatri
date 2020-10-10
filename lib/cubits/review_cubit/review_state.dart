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
  final double average;
  final ReviewDetails reviewsList;

  const ReviewLoaded({
    @required this.average,
    @required this.reviewsList,
  })  : assert(average != null),
        assert(reviewsList != null);
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({
    @required this.message,
  }) : assert(message != null);
}
