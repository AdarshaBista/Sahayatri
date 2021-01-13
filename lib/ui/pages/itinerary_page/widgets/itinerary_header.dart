import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/common/drag_indicator_pill.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader();

  @override
  Widget build(BuildContext context) {
    final itinerary = context.watch<Itinerary>();

    return SlideAnimator(
      begin: const Offset(0.0, 1.0),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          DragIndicatorPill(color: AppColors.light.withOpacity(0.25)),
          const SizedBox(height: 4.0),
          Text(
            itinerary.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headline4.serif.bold.light,
          ),
          const SizedBox(height: 6.0),
          Text(
            '${itinerary.days} days ${itinerary.nights} nights',
            textAlign: TextAlign.center,
            style: AppTextStyles.headline5.bold.light,
          ),
        ],
      ),
    );
  }
}
