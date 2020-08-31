import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class LodgeCard extends StatelessWidget {
  final Lodge lodge;

  const LodgeCard({
    @required this.lodge,
  }) : assert(lodge != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.repository<DestinationNavService>().pushNamed(
              Routes.kLodgePageRoute,
              arguments: lodge,
            );
      },
      child: ElevatedCard(
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
    return Hero(
      tag: lodge.id,
      child: GradientContainer(
        gradientColors: [
          Colors.transparent,
          AppColors.dark.withOpacity(0.2),
          AppColors.dark.withOpacity(0.6),
          AppColors.dark.withOpacity(0.8),
        ],
        child: AdaptiveImage(lodge.imageUrls[0]),
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
            style: AppTextStyles.small.bold.light,
          ),
          const SizedBox(height: 8.0),
          StarRatingBar(
            rating: lodge.rating,
            size: 14.0,
          ),
          Divider(height: 16.0, color: AppColors.lightAccent.withOpacity(0.5)),
          _buildContact(),
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
          lodge.contactNumbers.first,
          style: AppTextStyles.small.lightAccent,
        ),
      ],
    );
  }
}
