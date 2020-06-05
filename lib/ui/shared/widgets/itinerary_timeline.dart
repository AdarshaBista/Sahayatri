import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/checkpoint_form.dart';

class ItineraryTimeline extends StatelessWidget {
  final bool isNested;
  final bool isEditable;
  final ScrollController controller;
  final List<Checkpoint> checkpoints;

  double get indicatorWidth => 72.0;

  const ItineraryTimeline({
    @required this.checkpoints,
    this.isNested = false,
    this.isEditable = false,
    this.controller,
  })  : assert(isEditable != null),
        assert(checkpoints != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: ListView.builder(
        shrinkWrap: true,
        controller: controller,
        physics:
            isNested ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
        itemCount: checkpoints.length,
        itemBuilder: (context, index) {
          final bool isFirst = index == 0;
          final bool isLast = index == checkpoints.length - 1;
          final Checkpoint checkpoint = checkpoints[index];

          return IntrinsicHeight(
            child: SlideAnimator(
              begin: Offset(0.0, index * 100.0),
              child: Row(
                children: [
                  CustomPaint(
                    child: _buildDateTime(checkpoint),
                    foregroundPainter: _LinePainter(
                      isFirst: isFirst,
                      isLast: isLast,
                      indicatorWidth: indicatorWidth,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(child: _buildPlace(context, checkpoint)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateTime(Checkpoint checkpoint) {
    return Container(
      width: indicatorWidth,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              checkpoint.date,
              style: AppTextStyles.small.bold,
            ),
            const SizedBox(height: 4.0),
            Text(
              checkpoint.time,
              style: AppTextStyles.extraSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlace(BuildContext context, Checkpoint checkpoint) {
    return CustomCard(
      elevation: 0.0,
      color: AppColors.light,
      margin: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => _handlePlaceTap(context, checkpoint),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  checkpoint.place.imageUrls[0],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(child: _buildCheckpointText(checkpoint)),
              if (isEditable) _buildDeleteIcon(context, checkpoint),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePlaceTap(BuildContext context, Checkpoint checkpoint) {
    if (isEditable) {
      CheckpointForm(
        context: context,
        checkpoint: checkpoint,
        onSubmit: (updatedCheckpoint) => context.bloc<ItineraryFormBloc>().add(
              CheckpointUpdated(
                newCheckpoint: updatedCheckpoint,
                prevCheckpoint: checkpoint,
              ),
            ),
      ).show();
    } else {
      context.repository<DestinationNavService>().pushNamed(
            Routes.kPlacePageRoute,
            arguments: checkpoint.place,
          );
    }
  }

  Column _buildCheckpointText(Checkpoint checkpoint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkpoint.place.name,
          style: AppTextStyles.medium,
        ),
        const SizedBox(height: 4.0),
        Text(
          checkpoint.description,
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }

  GestureDetector _buildDeleteIcon(
      BuildContext context, Checkpoint checkpoint) {
    return GestureDetector(
      onTap: () => context
          .bloc<ItineraryFormBloc>()
          .add(CheckpointRemoved(checkpoint: checkpoint)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.close,
          size: 22.0,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final bool isFirst;
  final bool isLast;
  final double indicatorWidth;

  _LinePainter({
    @required this.isFirst,
    @required this.isLast,
    @required this.indicatorWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorPadding = indicatorWidth / 2.0;
    final linePaint = Paint()
      ..strokeWidth = 1.5
      ..color = AppColors.disabled
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final top = size.topLeft(Offset(indicatorPadding, -indicatorPadding / 2.0));
    final centerTop =
        size.centerLeft(Offset(indicatorPadding, -indicatorPadding));
    final centerBottom =
        size.centerLeft(Offset(indicatorPadding, indicatorPadding));
    final bottom =
        size.bottomLeft(Offset(indicatorPadding, indicatorPadding / 2.0));

    if (!isFirst) canvas.drawLine(top, centerTop, linePaint);
    if (!isLast) canvas.drawLine(centerBottom, bottom, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
