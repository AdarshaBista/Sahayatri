import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/models/next_checkpoint.dart';

import 'package:sahayatri/core/utils/image_utils.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_card/flip_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/upcoming_lodges_list.dart';

class NextCheckpointCard extends StatelessWidget {
  const NextCheckpointCard();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint =
        context.select<TrackerUpdate, NextCheckpoint>((u) => u.nextCheckpoint);
    if (nextCheckpoint == null) return const Offstage();

    final place = nextCheckpoint.checkpoint.place;
    return FadeAnimator(
      child: ElevatedCard(
        radius: 12.0,
        elevation: 8.0,
        color: AppColors.darkFaded,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: place.lodges.isEmpty ? 180.0 : 300.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ImageUtils.getImageProvider(place.imageUrls.first),
              colorFilter: ColorFilter.mode(
                AppColors.dark.withOpacity(0.85),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: const FlipCard(
            speed: 300,
            back: _CardBack(),
            front: _CardFront(),
            direction: FlipDirection.VERTICAL,
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
    final nextCheckpoint =
        context.select<TrackerUpdate, NextCheckpoint>((u) => u.nextCheckpoint);
    if (nextCheckpoint == null) return const Offstage();
    final place = nextCheckpoint.checkpoint.place;
    final lodges = place.lodges;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Next Checkpoint', style: AppTextStyles.headline5.light),
          const Spacer(),
          _buildTitle(context, place),
          const SizedBox(height: 10.0),
          _buildStatus(context),
          if (lodges.isNotEmpty) ...[
            const Divider(height: 20.0, color: AppColors.lightAccent),
            UpcomingLodgesList(lodges: lodges),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Place place) {
    return GestureDetector(
      onTap: () => locator<DestinationNavService>()
          .pushNamed(Routes.placePageRoute, arguments: place),
      child: Text(
        place.name.toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.headline5.light.bold,
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    final nextCheckpoint =
        context.select<TrackerUpdate, NextCheckpoint>((u) => u.nextCheckpoint);

    return Row(
      children: [
        Text(
          '${_formatDistance(nextCheckpoint.distance)} away',
          style: AppTextStyles.headline5.primary.bold,
        ),
        const Spacer(),
        Text(
          nextCheckpoint.eta != null
              ? 'ETA: ${nextCheckpoint.eta.inHours} hr ${nextCheckpoint.eta.inMinutes.remainder(60)} min'
              : '-',
          style: AppTextStyles.headline5.primary.bold,
        ),
      ],
    );
  }

  String _formatDistance(double distance) {
    if (distance < 2000.0) return '${distance.toStringAsFixed(0)} m';

    final distanceInKm = (distance / 1000.0).toStringAsFixed(2);
    return '$distanceInKm km';
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint =
        context.select<TrackerUpdate, NextCheckpoint>((u) => u.nextCheckpoint);

    if (nextCheckpoint == null) return const Offstage();
    final checkpoint = nextCheckpoint.checkpoint;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTime(checkpoint),
          const Divider(height: 12.0, color: AppColors.lightAccent),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                checkpoint.description.isEmpty
                    ? 'No description provided.'
                    : checkpoint.description,
                style: AppTextStyles.headline5.light,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTime(Checkpoint checkpoint) {
    return Row(
      children: [
        Text(
          checkpoint.time,
          style: AppTextStyles.headline5.primary.bold,
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(radius: 2.0),
        const SizedBox(width: 8.0),
        Text(
          checkpoint.date,
          style: AppTextStyles.headline6.primary,
        ),
      ],
    );
  }
}
