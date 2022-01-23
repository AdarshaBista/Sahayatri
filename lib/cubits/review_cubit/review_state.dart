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
  final ReviewDetails reviewDetails;

  const ReviewLoaded({
    required this.average,
    required this.reviewDetails,
  });
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({
    required this.message,
  });
}
