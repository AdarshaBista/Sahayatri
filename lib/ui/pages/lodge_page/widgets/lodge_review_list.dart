import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/models/lodge_review.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/review_form.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/lodge_page/widgets/lodge_review_card.dart';

class LodgeReviewList extends StatelessWidget {
  const LodgeReviewList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          BlocBuilder<LodgeReviewCubit, LodgeReviewState>(
            builder: (context, state) {
              if (state is LodgeReviewError) {
                return ErrorIndicator(
                  message: state.message,
                  onRetry: context.bloc<LodgeReviewCubit>().fetchReviews,
                );
              } else if (state is LodgeReviewLoaded) {
                return _buildList(state.reviews);
              } else if (state is LodgeReviewEmpty) {
                return EmptyIndicator(
                  onRetry: context.bloc<LodgeReviewCubit>().fetchReviews,
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

  Widget _buildList(List<LodgeReview> reviews) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return SlideAnimator(
          begin: Offset(0.0, 0.2 + index * 0.4),
          child: LodgeReviewCard(review: reviews[index]),
        );
      },
    );
  }

  Future<void> _postReview(BuildContext context, double rating, String text) async {
    context.openSnackBar('Posting lodge review...');
    final bool success = await context.bloc<LodgeReviewCubit>().postReview(rating, text);

    if (success) {
      context.openSnackBar('Lodge review posted');
    } else {
      context.openSnackBar('Failed to post lodge review!');
    }
  }
}
