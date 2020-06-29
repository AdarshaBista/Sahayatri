import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class NextStopCard extends StatelessWidget {
  final Place place;
  final Duration eta;

  const NextStopCard({
    @required this.eta,
    @required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return place != null
        ? FadeAnimator(
            child: AspectRatio(
              aspectRatio: 2.3,
              child: GestureDetector(
                onTap: () {
                  context
                      .repository<DestinationNavService>()
                      .pushNamed(Routes.kPlacePageRoute, arguments: place);
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    _buildBackground(),
                    _buildTitle(),
                  ],
                ),
              ),
            ),
          )
        : const Offstage();
  }

  Widget _buildBackground() {
    return CustomCard(
      child: GradientContainer(
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
        gradientColors: [
          AppColors.dark.withOpacity(0.8),
          AppColors.dark.withOpacity(0.6),
          AppColors.dark.withOpacity(0.4),
          AppColors.dark.withOpacity(0.2),
          Colors.transparent,
        ],
        child: Image.asset(
          place.imageUrls[0],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
          Text(
            'NEXT STOP',
            style: AppTextStyles.medium.bold.light,
          ),
          const Spacer(),
          Text(
            place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.small.light,
          ),
          Divider(
            color: AppColors.light.withOpacity(0.5),
            height: 10.0,
            endIndent: 64.0,
          ),
          Text(
            eta != null
                ? 'ETA: ${eta.inHours} hr ${eta.inMinutes.remainder(60)} min'
                : '-',
            style: AppTextStyles.small.bold.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNoNextStop() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'No next stop!',
            style: AppTextStyles.medium,
          ),
        ),
      ],
    );
  }
}
