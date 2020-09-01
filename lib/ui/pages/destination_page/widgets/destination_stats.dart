import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class DestinationStats extends StatelessWidget {
  const DestinationStats();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
