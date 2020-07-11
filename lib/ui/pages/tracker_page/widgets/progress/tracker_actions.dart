import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_stop_dialog.dart';

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
                  child: _buildTile(
                    label: 'RESUME',
                    color: AppColors.primaryDark,
                    icon: CommunityMaterialIcons.play_circle_outline,
                    onTap: () => context.repository<TrackerBloc>().add(
                          const TrackingResumed(),
                        ),
                  ),
                ),
              if (trackerUpdate.trackingState == TrackingState.updating)
                Expanded(
                  child: _buildTile(
                    label: 'PAUSE',
                    color: Colors.blue,
                    icon: CommunityMaterialIcons.pause_circle_outline,
                    onTap: () => context.repository<TrackerBloc>().add(
                          const TrackingPaused(),
                        ),
                  ),
                ),
              Expanded(
                child: _buildTile(
                  label: 'STOP',
                  color: AppColors.secondary,
                  icon: CommunityMaterialIcons.stop_circle_outline,
                  onTap: () => TrackerStopDialog(
                    onStop: () => context.repository<TrackerBloc>().add(
                          const TrackingStopped(),
                        ),
                  ).openDialog(context),
                ),
              ),
            ],
          );
  }

  Widget _buildTile({Color color, String label, IconData icon, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 36.0,
              color: color.withOpacity(0.8),
            ),
            const SizedBox(height: 4.0),
            AnimatedDefaultTextStyle(
              child: Text(label),
              duration: const Duration(milliseconds: 300),
              style: AppTextStyles.small.bold.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
