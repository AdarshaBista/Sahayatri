import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/services/location/location_service.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/toggle_grid.dart';

import 'package:sahayatri/locator.dart';

class GpsAccuracyToggle extends StatelessWidget {
  const GpsAccuracyToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleGrid<String>(
      title: 'Location Accuracy',
      initialValue: BlocProvider.of<PrefsCubit>(context).prefs.gpsAccuracy,
      onSelected: (accuracy) => onSelected(context, accuracy),
      items: [
        ToggleItem(
          label: 'Low',
          value: GpsAccuracy.low,
          icon: AppIcons.accuracyLow,
        ),
        ToggleItem(
          label: 'Balanced',
          value: GpsAccuracy.balanced,
          icon: AppIcons.accuracyBalanced,
        ),
        ToggleItem(
          label: 'High',
          value: GpsAccuracy.high,
          icon: AppIcons.accuracyHigh,
        ),
      ],
    );
  }

  void onSelected(BuildContext context, String accuracy) {
    locator<LocationService>().setLocationAccuracy(accuracy);
    locator<LocationService>(instanceName: 'mock')
        .setLocationAccuracy(accuracy);
    context.read<PrefsCubit>().saveGpsAccuracy(accuracy);
  }
}
