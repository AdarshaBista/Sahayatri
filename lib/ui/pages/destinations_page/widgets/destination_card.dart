import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({
    @required this.destination,
  }) : assert(destination != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: AspectRatio(
        aspectRatio: 2.2,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            context.repository<RootNavService>().pushNamed(
                  Routes.kDestinationPageRoute,
                  arguments: destination,
                );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _buildBackground(),
                _buildTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Hero(
      tag: destination.id.toString(),
      child: CustomCard(
        child: GradientContainer(
          gradientEnd: Alignment.topRight,
          gradientBegin: Alignment.bottomCenter,
          gradientColors: [
            AppColors.dark.withOpacity(0.7),
            AppColors.dark.withOpacity(0.5),
            AppColors.dark.withOpacity(0.2),
            Colors.transparent,
          ],
          child: Image.asset(
            destination.imageUrls[0],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          StarRatingBar(
            rating: destination.rating,
            size: 16.0,
          ),
          const SizedBox(height: 8.0),
          FadeAnimator(
            child: Text(
              destination.name.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.medium.light,
            ),
          ),
          Divider(
            color: AppColors.lightAccent.withOpacity(0.5),
            height: 10.0,
            endIndent: 64.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: FadeAnimator(
              child: Text(
                destination.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.extraSmall.light,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
