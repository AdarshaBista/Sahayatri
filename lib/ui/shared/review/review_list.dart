import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/review/review_form.dart';
import 'package:sahayatri/ui/shared/review/review_card.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

class ReviewList extends StatelessWidget {
  final ReviewCubit reviewCubit;

  const ReviewList({
    @required this.reviewCubit,
  }) : assert(reviewCubit != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.bloc<UserCubit>().isAuthenticated)
            CustomButton(
              label: 'Write a review',
              outlineOnly: true,
              color: AppColors.dark,
              backgroundColor: AppColors.barrier,
              iconData: CommunityMaterialIcons.pencil_outline,
              onTap: () => ReviewForm(
                onSubmit: (rating, text) async => _postReview(context, rating, text),
              ).openModalBottomSheet(context),
            ),
          const SizedBox(height: 8.0),
          BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewError) {
                return ErrorIndicator(
                  message: state.message,
                  onRetry: context.bloc<ReviewCubit>().fetchReviews,
                );
              } else if (state is ReviewLoaded) {
                return _buildList(state.reviews);
              } else if (state is ReviewEmpty) {
                return EmptyIndicator(
                  message: 'No reviews yet.',
                  onRetry: context.bloc<ReviewCubit>().fetchReviews,
                );
              } else {
                return const BusyIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Review> reviews) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const Divider(height: 8.0),
      itemBuilder: (context, index) {
        return SlideAnimator(
          begin: Offset(0.0, 0.2 + index * 0.4),
          child: ReviewCard(review: reviews[index]),
        );
      },
    );
  }

  Future<void> _postReview(BuildContext context, double rating, String text) async {
    context.openSnackBar('Posting review...');
    final bool success = await reviewCubit.postReview(rating, text);

    if (success) {
      context.openSnackBar('Review posted');
    } else {
      context.openSnackBar('Failed to post review!');
    }
  }
}
