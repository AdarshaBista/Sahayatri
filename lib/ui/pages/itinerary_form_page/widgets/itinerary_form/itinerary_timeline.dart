import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/checkpoint_form.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';
import 'package:sahayatri/ui/widgets/checkpoint/notify_contact_status.dart';
import 'package:sahayatri/ui/widgets/image/adaptive_image.dart';

import 'package:sahayatri/locator.dart';

class ItineraryTimeline extends StatelessWidget {
  final bool isNested;
  final bool isEditable;
  final List<Checkpoint> checkpoints;
  final ScrollController? controller;

  const ItineraryTimeline({
    super.key,
    required this.checkpoints,
    this.isNested = false,
    this.isEditable = false,
    this.controller,
  });

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
        physics: isNested ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
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
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        indicator: _buildIndicator(checkpoint),
      ),
      beforeLineStyle: const LineStyle(
        thickness: 1.5,
        color: AppColors.primary,
      ),
      afterLineStyle: const LineStyle(
        thickness: 1.5,
        color: AppColors.primary,
      ),
      startChild: _buildDateTime(context, checkpoint),
      endChild: _buildPlace(context, checkpoint),
    );
  }

  Widget _buildIndicator(Checkpoint checkpoint) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: checkpoint.place.imageUrls.isEmpty
          ? const Center(child: Icon(AppIcons.place))
          : AdaptiveImage(checkpoint.place.imageUrls.first),
    );
  }

  Widget _buildDateTime(BuildContext context, Checkpoint checkpoint) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            checkpoint.date,
            style: context.t.headlineSmall?.bold,
          ),
          if (!checkpoint.isTemplate) const SizedBox(height: 4.0),
          if (!checkpoint.isTemplate)
            Text(
              checkpoint.time,
              style: context.t.titleLarge,
            ),
        ],
      ),
    );
  }

  Widget _buildPlace(BuildContext context, Checkpoint checkpoint) {
    return InkWell(
      splashColor: context.c.surface,
      borderRadius: BorderRadius.circular(8.0),
      onTap: () => _handlePlaceTap(context, checkpoint),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(child: _buildCheckpointText(context, checkpoint)),
            const SizedBox(width: 8.0),
            if (isEditable) _buildDeleteIcon(context, checkpoint),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckpointText(BuildContext context, Checkpoint checkpoint) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkpoint.place.name.toUpperCase(),
          style: context.t.headlineSmall?.bold,
        ),
        const SizedBox(height: 4.0),
        Text(
          checkpoint.description.isEmpty ? 'No description provided.' : checkpoint.description,
          style: context.t.titleLarge,
        ),
        const SizedBox(height: 4.0),
        NotifyContactStatus(isNotified: checkpoint.notifyContact),
      ],
    );
  }

  Widget _buildDeleteIcon(BuildContext context, Checkpoint checkpoint) {
    return CircularButton(
      size: 14.0,
      padding: 5.0,
      icon: AppIcons.close,
      color: AppColors.secondary,
      backgroundColor: context.c.surface,
      onTap: () => context.read<ItineraryFormCubit>().removeCheckpoint(checkpoint),
    );
  }

  void _handlePlaceTap(BuildContext context, Checkpoint checkpoint) {
    if (isEditable) {
      CheckpointForm(
        checkpoint: checkpoint,
        onSubmit: (updatedCheckpoint) =>
            context.read<ItineraryFormCubit>().updateCheckpoint(checkpoint, updatedCheckpoint),
      ).openModalBottomSheet(context, enableDrag: false);
    } else {
      locator<DestinationNavService>().pushNamed(
        Routes.placePageRoute,
        arguments: checkpoint.place,
      );
    }
  }
}
