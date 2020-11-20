import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/adaptive_image.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/checkpoint_form.dart';

class ItineraryTimeline extends StatelessWidget {
  final bool isNested;
  final bool isEditable;
  final ScrollController controller;
  final List<Checkpoint> checkpoints;

  const ItineraryTimeline({
    @required this.checkpoints,
    this.controller,
    this.isNested = false,
    this.isEditable = false,
  })  : assert(isEditable != null),
        assert(checkpoints != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: ListView.builder(
        shrinkWrap: true,
        controller: controller,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        physics: isNested
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        itemCount: checkpoints.length,
        itemBuilder: (context, index) {
          final bool isFirst = index == 0;
          final bool isLast = index == checkpoints.length - 1;
          final Checkpoint checkpoint = checkpoints[index];

          return SlideAnimator(
            begin: Offset(0.0, 0.2 + index * 0.4),
            child: _buildTile(context, isLast, isFirst, checkpoint),
          );
        },
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    bool isLast,
    bool isFirst,
    Checkpoint checkpoint,
  ) {
    return TimelineTile(
      lineXY: 0.3,
      isLast: isLast,
      isFirst: isFirst,
      alignment: TimelineAlign.manual,
      indicatorStyle: IndicatorStyle(
        width: 44.0,
        height: 44.0,
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        indicator: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: AdaptiveImage(checkpoint.place.imageUrls[0]),
        ),
      ),
      beforeLineStyle: const LineStyle(
        thickness: 1.5,
        color: AppColors.disabled,
      ),
      afterLineStyle: const LineStyle(
        thickness: 1.5,
        color: AppColors.disabled,
      ),
      startChild: _buildDateTime(checkpoint),
      endChild: _buildPlace(context, checkpoint),
    );
  }

  Widget _buildDateTime(Checkpoint checkpoint) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            checkpoint.date,
            style: AppTextStyles.small.bold,
          ),
          if (!checkpoint.isTemplate) const SizedBox(height: 4.0),
          if (!checkpoint.isTemplate)
            Text(
              checkpoint.time,
              style: AppTextStyles.extraSmall,
            ),
        ],
      ),
    );
  }

  Widget _buildPlace(BuildContext context, Checkpoint checkpoint) {
    return InkWell(
      onTap: () => _handlePlaceTap(context, checkpoint),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCheckpointText(checkpoint)),
            if (isEditable) _buildDeleteIcon(context, checkpoint),
          ],
        ),
      ),
    );
  }

  Column _buildCheckpointText(Checkpoint checkpoint) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkpoint.place.name.toUpperCase(),
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          checkpoint.description.isEmpty
              ? 'No description provided.'
              : checkpoint.description,
          style: AppTextStyles.extraSmall,
        ),
        if (checkpoint.notifyContact) ...[
          const SizedBox(height: 4.0),
          _buildSmsStatus(),
        ],
      ],
    );
  }

  Widget _buildSmsStatus() {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          size: 12.0,
          color: AppColors.primaryDark,
        ),
        const SizedBox(width: 4.0),
        Text(
          'Notify contact',
          style: AppTextStyles.extraSmall.primaryDark,
        ),
      ],
    );
  }

  GestureDetector _buildDeleteIcon(BuildContext context, Checkpoint checkpoint) {
    return GestureDetector(
      onTap: () => context.read<ItineraryFormCubit>().removeCheckpoint(checkpoint),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.close,
          size: 22.0,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  void _handlePlaceTap(BuildContext context, Checkpoint checkpoint) {
    if (isEditable) {
      CheckpointForm(
        checkpoint: checkpoint,
        onSubmit: (updatedCheckpoint) => context
            .read<ItineraryFormCubit>()
            .updateCheckpoint(checkpoint, updatedCheckpoint),
      ).openModalBottomSheet(context, isDismissible: false);
    } else {
      context.read<DestinationNavService>().pushNamed(
            Routes.placePageRoute,
            arguments: checkpoint.place,
          );
    }
  }
}
