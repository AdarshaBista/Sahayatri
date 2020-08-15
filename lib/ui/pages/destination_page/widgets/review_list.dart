import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/auth_cubit/auth_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/review_form.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/review_card.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({
    @required this.reviews,
  }) : assert(reviews != null);

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
              onTap: () =>
                  ReviewForm(onSubmit: (rating, text) {}).openModalBottomSheet(context),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return SlideAnimator(
                begin: Offset(0.0, 0.2 + index * 0.4),
                child: ReviewCard(review: reviews[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
