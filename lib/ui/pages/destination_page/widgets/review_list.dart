import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';
import 'package:sahayatri/cubits/destination_review_cubit/destination_review_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/review_form.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/review_card.dart';

class ReviewList extends StatelessWidget {
  const ReviewList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (context.bloc<AuthCubit>().isAuthenticated)
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
          BlocBuilder<DestinationReviewCubit, DestinationReviewState>(
            builder: (context, state) {
              if (state is DestinationReviewError) {
                return ErrorIndicator(
                  message: state.message,
                  onRetry: context.bloc<DestinationReviewCubit>().fetchReviews,
                );
              } else if (state is DestinationReviewLoaded) {
                return _buildList(state.reviews);
              } else if (state is DestinationReviewEmpty) {
                return EmptyIndicator(
                  onRetry: context.bloc<DestinationReviewCubit>().fetchReviews,
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
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
    final bool success = await context
        .bloc<DestinationReviewCubit>()
        .postReview(rating, text, context.bloc<AuthCubit>().user);

    if (success) {
      context.openSnackBar('Review posted');
    } else {
      context.openSnackBar('Failed to post review!');
    }
  }
}
