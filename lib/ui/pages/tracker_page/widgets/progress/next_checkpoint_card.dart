import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/flip_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/widgets/gradient_container.dart';

class NextCheckpointCard extends StatelessWidget {
  const NextCheckpointCard();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;

    return nextCheckpoint != null
        ? FadeAnimator(
            child: AspectRatio(
              aspectRatio: 2.3,
              child: GestureDetector(
                onTap: () {},
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
            ),
          )
        : const Offstage();
  }

  Widget _buildBackground(BuildContext context) {
    final place = context.watch<TrackerUpdate>().nextCheckpoint.checkpoint.place;

    return CustomCard(
      elevation: 6.0,
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
          const Divider(height: 16.0, color: AppColors.lightAccent),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Text(
                checkpoint.description.isEmpty
                    ? 'No description provided.'
                    : checkpoint.description,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.light,
              ),
            ),
          ),
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
