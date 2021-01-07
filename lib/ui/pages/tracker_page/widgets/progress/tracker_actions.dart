import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class TrackerActions extends StatelessWidget {
  const TrackerActions();

  @override
  Widget build(BuildContext context) {
    final trackingState =
        context.select<TrackerUpdate, TrackingState>((u) => u.trackingState);

    return trackingState == TrackingState.stopped
        ? const Offstage()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (trackingState == TrackingState.paused)
                  Expanded(
                    child: CustomButton(
                      label: 'RESUME',
                      color: context.c.onBackground,
                      backgroundColor: Colors.teal.withOpacity(0.5),
                      icon: CommunityMaterialIcons.play_circle_outline,
                      onTap: () => context.read<TrackerCubit>().resumeTracking(),
                    ),
                  ),
                if (trackingState == TrackingState.updating)
                  Expanded(
                    child: CustomButton(
                      label: 'PAUSE',
                      color: context.c.onBackground,
                      backgroundColor: Colors.lightBlue.withOpacity(0.5),
                      icon: CommunityMaterialIcons.pause_circle_outline,
                      onTap: () => context.read<TrackerCubit>().pauseTracking(),
                    ),
                  ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: CustomButton(
                    label: 'STOP',
                    color: context.c.onBackground,
                    backgroundColor: Colors.red.withOpacity(0.5),
                    icon: CommunityMaterialIcons.stop_circle_outline,
                    onTap: () => ConfirmDialog(
                      message: 'Are you sure you want to stop the tracking process.',
                      onConfirm: () => context.read<TrackerCubit>().stopTracking(),
                    ).openDialog(context),
                  ),
                ),
              ],
            ),
          );
  }
}
