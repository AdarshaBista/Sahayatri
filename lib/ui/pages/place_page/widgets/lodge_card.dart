import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class LodgeCard extends StatelessWidget {
  final Lodge lodge;

  const LodgeCard({
    @required this.lodge,
  }) : assert(lodge != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          _buildBackground(),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return GradientContainer(
      gradientColors: [
        Colors.transparent,
        AppColors.dark.withOpacity(0.5),
        AppColors.dark,
      ],
      child: Image.asset(
        lodge.imageUrls[0],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            lodge.name,
            style: AppTextStyles.medium.light,
          ),
          Divider(height: 16.0, color: AppColors.lightAccent.withOpacity(0.5)),
          _buildContact(),
          const SizedBox(height: 8.0),
          StarRatingBar(
            rating: lodge.rating,
            size: 14.0,
          ),
        ],
      ),
    );
  }

  Widget _buildContact() {
    return Row(
      children: [
        const Icon(
          Icons.phone,
          size: 14.0,
          color: AppColors.lightAccent,
        ),
        const SizedBox(width: 6.0),
        Text(
          lodge.contactNumber,
          style: AppTextStyles.small.lightAccent,
        ),
      ],
    );
  }
}
