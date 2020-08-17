part of 'destination_review_cubit.dart';

abstract class DestinationReviewState {
  const DestinationReviewState();
}

class DestinationReviewEmpty extends DestinationReviewState {
  const DestinationReviewEmpty();
}

class DestinationReviewLoading extends DestinationReviewState {
  const DestinationReviewLoading();
}

class DestinationReviewLoaded extends DestinationReviewState {
  final List<Review> reviews;

  const DestinationReviewLoaded({
    @required this.reviews,
  }) : assert(reviews != null);
}

class DestinationReviewError extends DestinationReviewState {
  final String message;

  const DestinationReviewError({
    @required this.message,
  }) : assert(message != null);
}
