import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader();

  @override
  Widget build(BuildContext context) {
    final itinerary = context.watch<Itinerary>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          itinerary.name,
          textAlign: TextAlign.center,
          style: AppTextStyles.headline3.bold,
        ),
        const SizedBox(height: 2.0),
        Text(
          '${itinerary.days} days ${itinerary.nights} nights',
          textAlign: TextAlign.center,
          style: AppTextStyles.headline5.bold,
        ),
      ],
    );
  }
}
