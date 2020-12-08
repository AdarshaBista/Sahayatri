import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/constants/images.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';
import 'package:sahayatri/ui/widgets/common/gradient_container.dart';

class LodgeCard extends StatelessWidget {
  final Lodge lodge;

  const LodgeCard({
    @required this.lodge,
  }) : assert(lodge != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<DestinationNavService>()
          .pushNamed(Routes.lodgePageRoute, arguments: lodge),
      child: ElevatedCard(
        radius: 8.0,
        color: context.c.surface,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            _buildBackground(),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    String imageUrl = Images.splash;
    if (lodge.imageUrls != null && lodge.imageUrls.isNotEmpty) {
      imageUrl = lodge.imageUrls.first;
    }

    return Hero(
      tag: lodge.id,
      child: GradientContainer(
        child: AdaptiveImage(imageUrl),
        gradientColors: AppColors.cardGradient,
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StarRatingBar(
            rating: lodge.rating,
            size: 12.0,
          ),
          Divider(height: 8.0, color: AppColors.lightFaded),
          Flexible(
            child: Text(
              lodge.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headline5.bold.light,
            ),
          ),
        ],
      ),
    );
  }
}
