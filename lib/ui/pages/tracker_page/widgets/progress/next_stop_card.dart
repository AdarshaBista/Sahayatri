import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class NextStopCard extends StatelessWidget {
  const NextStopCard();

  @override
  Widget build(BuildContext context) {
    final nextStop = context.watch<TrackerUpdate>().nextStop;

    return nextStop != null
        ? FadeAnimator(
            child: AspectRatio(
              aspectRatio: 2.3,
              child: GestureDetector(
                onTap: () {
                  context
                      .repository<DestinationNavService>()
                      .pushNamed(Routes.kPlacePageRoute, arguments: nextStop.place);
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    _buildBackground(context),
                    _buildOverlay(context),
                  ],
                ),
              ),
            ),
          )
        : const Offstage();
  }

  Widget _buildBackground(BuildContext context) {
    final place = context.watch<TrackerUpdate>().nextStop.place;
    return CustomCard(
      elevation: 8.0,
      child: Hero(
        tag: place.name,
        child: GradientContainer(
          gradientBegin: Alignment.bottomCenter,
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
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final nextStop = context.watch<TrackerUpdate>().nextStop;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'NEXT STOP',
            style: AppTextStyles.medium.light,
          ),
          const Spacer(),
          Text(
            nextStop.place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.small.light.bold,
          ),
          Divider(
            color: AppColors.lightAccent.withOpacity(0.5),
            height: 10.0,
            endIndent: 64.0,
          ),
          _buildStatus(context),
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    final nextStop = context.watch<TrackerUpdate>().nextStop;

    return Row(
      children: [
        Text(
          '${nextStop.distance.toStringAsFixed(0)} m away',
          style: AppTextStyles.small.primary.bold,
        ),
        const Spacer(),
        Text(
          nextStop.eta != null
              ? 'ETA: ${nextStop.eta.inHours} hr ${nextStop.eta.inMinutes.remainder(60)} min'
              : '-',
          style: AppTextStyles.small.primary.bold,
        ),
      ],
    );
  }
}
