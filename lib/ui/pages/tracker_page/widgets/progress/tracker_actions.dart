import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/dialogs/confirm_dialog.dart';

class TrackerActions extends StatelessWidget {
  const TrackerActions();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return trackerUpdate.trackingState == TrackingState.stopped
        ? const Offstage()
        : Row(
            children: [
              if (trackerUpdate.trackingState == TrackingState.paused)
                Expanded(
                  child: CustomButton(
                    label: 'Resume',
                    color: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    iconData: CommunityMaterialIcons.play_circle_outline,
                    onTap: context.repository<TrackerCubit>().resumeTracking,
                  ),
                ),
              if (trackerUpdate.trackingState == TrackingState.updating)
                Expanded(
                  child: CustomButton(
                    label: 'Pause',
                    color: Colors.blue,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    iconData: CommunityMaterialIcons.pause_circle_outline,
                    onTap: context.repository<TrackerCubit>().pauseTracking,
                  ),
                ),
              const SizedBox(width: 8.0),
              Expanded(
                child: CustomButton(
                  label: 'Stop',
                  color: Colors.red,
                  backgroundColor: Colors.red.withOpacity(0.2),
                  iconData: CommunityMaterialIcons.stop_circle_outline,
                  onTap: () => ConfirmDialog(
                    message: 'Are you sure you want to stop the tracking process.',
                    onConfirm: () => context.repository<TrackerCubit>().stopTracking(),
                  ).openDialog(context),
                ),
              ),
            ],
          );
  }
}
