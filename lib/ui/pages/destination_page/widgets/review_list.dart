import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/review.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/custom_button.dart';
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
          CustomButton(
            label: 'Write a review',
            color: AppColors.dark,
            backgroundColor: AppColors.light,
            iconData: CommunityMaterialIcons.pencil_outline,
            onTap: () {},
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index]);
            },
          ),
        ],
      ),
    );
  }
}
