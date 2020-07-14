import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader();

  @override
  Widget build(BuildContext context) {
    final itinerary = Provider.of<Itinerary>(context, listen: false);

    return ListTile(
      dense: true,
      title: Text(
        itinerary.name,
        textAlign: TextAlign.center,
        style: AppTextStyles.large.bold,
      ),
      subtitle: Text(
        '${itinerary.days} days ${itinerary.nights} nights',
        textAlign: TextAlign.center,
        style: AppTextStyles.small.bold,
      ),
    );
  }
}
