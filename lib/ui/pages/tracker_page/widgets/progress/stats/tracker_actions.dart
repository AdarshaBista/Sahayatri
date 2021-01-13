import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class TrackerActions extends StatelessWidget {
  const TrackerActions();

  @override
  Widget build(BuildContext context) {
    final trackingState = context.watch<TrackerUpdate>().trackingState;
    if (trackingState == TrackingState.stopped) return const Offstage();

    return Row(
      children: [
        if (trackingState == TrackingState.paused)
          Expanded(
            child: CustomButton(
              label: 'RESUME',
              icon: AppIcons.resumeTracker,
              color: context.c.onBackground,
              backgroundColor: Colors.teal.withOpacity(0.3),
              onTap: () => context.read<TrackerCubit>().resumeTracking(),
            ),
          ),
        if (trackingState == TrackingState.updating)
          Expanded(
            child: CustomButton(
              label: 'PAUSE',
              icon: AppIcons.pauseTracker,
              color: context.c.onBackground,
              backgroundColor: Colors.lightBlue.withOpacity(0.3),
              onTap: () => context.read<TrackerCubit>().pauseTracking(),
            ),
          ),
        const SizedBox(width: 12.0),
        Expanded(
          child: CustomButton(
            label: 'STOP',
            icon: AppIcons.stopTracker,
            color: context.c.onBackground,
            backgroundColor: Colors.red.withOpacity(0.3),
            onTap: () => ConfirmDialog(
              message: 'Are you sure you want to stop the tracking process.',
              onConfirm: () => context.read<TrackerCubit>().stopTracking(),
            ).openDialog(context),
          ),
        ),
      ],
    );
  }
}
