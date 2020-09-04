import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/flip_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';
import 'package:sahayatri/ui/shared/widgets/adaptive_image.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class NextCheckpointCard extends StatelessWidget {
  const NextCheckpointCard();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;

    return nextCheckpoint == null
        ? const Offstage()
        : FadeAnimator(
            child: Container(
              height: 180.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  _buildBackground(context),
                  const FlipCard(
                    speed: 300,
                    back: _CardBack(),
                    front: _CardFront(),
                    direction: FlipDirection.VERTICAL,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildBackground(BuildContext context) {
    final place = context.watch<TrackerUpdate>().nextCheckpoint.checkpoint.place;

    return ElevatedCard(
      elevation: 8.0,
      borderRadius: 8.0,
      child: Hero(
        tag: place.id,
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
          child: AdaptiveImage(place.imageUrls[0]),
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront();

  @override
  Widget build(BuildContext context) {
    final place = context.watch<TrackerUpdate>().nextCheckpoint.checkpoint.place;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context, place),
          const Spacer(),
          Text(
            place.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.medium.light,
          ),
          Divider(height: 10.0, color: AppColors.lightAccent.withOpacity(0.5)),
          _buildStatus(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Place place) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEXT CHECKPOINT',
          style: AppTextStyles.small.light.bold,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => context.repository<DestinationNavService>().pushNamed(
                Routes.kPlacePageRoute,
                arguments: place,
              ),
          child: const ScaleAnimator(
            child: CircleAvatar(
              radius: 16.0,
              backgroundColor: AppColors.dark,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatus(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;

    return Row(
      children: [
        Text(
          '${nextCheckpoint.distance.toStringAsFixed(0)} m away',
          style: AppTextStyles.small.primary.bold,
        ),
        const Spacer(),
        Text(
          nextCheckpoint.eta != null
              ? 'ETA: ${nextCheckpoint.eta.inHours} hr ${nextCheckpoint.eta.inMinutes.remainder(60)} min'
              : '-',
          style: AppTextStyles.small.primary.bold,
        ),
      ],
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack();

  @override
  Widget build(BuildContext context) {
    final checkpoint = context.watch<TrackerUpdate>().nextCheckpoint.checkpoint;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.small.primary.bold,
          ),
          const Divider(height: 12.0, color: AppColors.lightAccent),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                checkpoint.description.isEmpty
                    ? 'No description provided.'
                    : checkpoint.description,
                style: AppTextStyles.small.light,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          _buildDateTime(checkpoint),
        ],
      ),
    );
  }

  Widget _buildDateTime(Checkpoint checkpoint) {
    return Row(
      children: [
        Text(
          checkpoint.time,
          style: AppTextStyles.small.primary.bold,
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(radius: 2.0),
        const SizedBox(width: 8.0),
        Text(
          checkpoint.date,
          style: AppTextStyles.extraSmall.primary,
        ),
      ],
    );
  }
}
