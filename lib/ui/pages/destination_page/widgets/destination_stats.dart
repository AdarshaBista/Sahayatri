import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_card.dart';

class DestinationStats extends StatelessWidget {
  const DestinationStats();

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<Destination>();

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Length',
            count: '${destination.length} km',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Altitude',
            count: '${destination.maxAltitude} m',
            color: AppColors.primaryDark,
          ),
          StatCard(
            label: 'Duration',
            count: '${destination.estimatedDuration} days',
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
