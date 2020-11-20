import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/review/review_form.dart';
import 'package:sahayatri/ui/widgets/review/review_card.dart';
import 'package:sahayatri/ui/widgets/review/rating_chart.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/buttons/view_more_button.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class ReviewList extends StatelessWidget {
  final ReviewCubit reviewCubit;

  const ReviewList({
    @required this.reviewCubit,
  }) : assert(reviewCubit != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.watch<UserCubit>().isAuthenticated)
            _buildWriteReviewButton(context),
          const SizedBox(height: 8.0),
          _buildReviews(context),
        ],
      ),
    );
  }

  Widget _buildWriteReviewButton(BuildContext context) {
    return CustomButton(
      label: 'Write a review',
      color: AppColors.primaryDark,
      backgroundColor: AppColors.primaryLight,
      iconData: CommunityMaterialIcons.pencil_outline,
      onTap: () => ReviewForm(
        onSubmit: (rating, text) => _postReview(context, rating, text),
      ).openModalBottomSheet(context, isDismissible: false),
    );
  }

  Widget _buildReviews(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewError) {
          return ErrorIndicator(
            message: state.message,
            onRetry: () => context.read<ReviewCubit>().fetchReviews(),
          );
        } else if (state is ReviewLoaded) {
          return _buildList(context, state);
        } else if (state is ReviewEmpty) {
          return EmptyIndicator(
            message: 'No reviews yet.',
            onRetry: () => context.read<ReviewCubit>().fetchReviews(),
          );
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, ReviewLoaded state) {
    final reviewDetails = state.reviewDetails;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RatingChart(
          total: reviewDetails.total,
          stars: reviewDetails.stars,
          average: state.average,
        ),
        const Divider(height: 0.0),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviewDetails.reviews.length,
          separatorBuilder: (_, __) => const Divider(height: 2.0),
          itemBuilder: (context, index) {
            return SlideAnimator(
              begin: Offset(0.0, 0.2 + index * 0.4),
              child: ReviewCard(review: reviewDetails.reviews[index]),
            );
          },
        ),
        ViewMoreButton(
          hasMore: reviewCubit.hasMore,
          onLoadMore: reviewCubit.loadMore,
        ),
      ],
    );
  }

  Future<void> _postReview(BuildContext context, double rating, String text) async {
    Navigator.of(context).pop();
    final success = await reviewCubit.postReview(rating, text);
    if (success) {
      context.openFlushBar('Review posted', type: FlushbarType.success);
    } else {
      context.openFlushBar('Failed to post review!', type: FlushbarType.error);
    }
  }
}
