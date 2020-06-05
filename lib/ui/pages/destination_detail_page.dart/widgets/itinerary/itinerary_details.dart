import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/itinerary_timeline.dart';

class ItineraryDetails {
  final BuildContext context;
  final Itinerary itinerary;

  const ItineraryDetails({
    @required this.context,
    @required this.itinerary,
  })  : assert(context != null),
        assert(itinerary != null);

  Widget _build() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          Text(
            itinerary.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.large,
          ),
          Text(
            '${itinerary.days} days ${itinerary.nights} nights',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
          ),
          const Divider(height: 20.0),
          Expanded(
            child: ItineraryTimeline(checkpoints: itinerary.checkpoints),
          ),
        ],
      ),
    );
  }

  void show() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: false,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      barrierColor: AppColors.dark.withOpacity(0.4),
      builder: (_) => _build(),
    );
  }
}
