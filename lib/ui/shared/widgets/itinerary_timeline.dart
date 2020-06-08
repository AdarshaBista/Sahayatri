import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/app/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
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
            child: TimelineTile(
              lineX: 0.3,
              isLast: isLast,
              isFirst: isFirst,
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                width: 44.0,
                height: 44.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                indicator: CircleAvatar(
                  backgroundImage: AssetImage(checkpoint.place.imageUrls[0]),
                ),
              ),
              topLineStyle: const LineStyle(
                width: 1.5,
                color: AppColors.disabled,
              ),
              bottomLineStyle: const LineStyle(
                width: 1.5,
                color: AppColors.disabled,
              ),
              leftChild: _buildDateTime(checkpoint),
              rightChild: _buildPlace(context, checkpoint),
            ),
          );
        },
      ),
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
      ],
    );
  }

  GestureDetector _buildDeleteIcon(
    BuildContext context,
    Checkpoint checkpoint,
  ) {
    return GestureDetector(
      onTap: () => context
          .bloc<ItineraryFormBloc>()
          .add(CheckpointRemoved(checkpoint: checkpoint)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.close,
          size: 22.0,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  void _handlePlaceTap(BuildContext context, Checkpoint checkpoint) {
    if (isEditable) {
      CheckpointForm(
        checkpoint: checkpoint,
        onSubmit: (updatedCheckpoint) => context.bloc<ItineraryFormBloc>().add(
              CheckpointUpdated(
                newCheckpoint: updatedCheckpoint,
                prevCheckpoint: checkpoint,
              ),
            ),
      ).openModalBottomSheet(context);
    } else {
      context.repository<DestinationNavService>().pushNamed(
            Routes.kPlacePageRoute,
            arguments: checkpoint.place,
          );
    }
  }
}
