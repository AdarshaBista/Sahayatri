import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';

class TrackerActions extends StatelessWidget {
  const TrackerActions();

  @override
  Widget build(BuildContext context) {
    final trackerUpdate = context.watch<TrackerUpdate>();

    return trackerUpdate.trackingState == TrackingState.stopped
        ? const Offstage()
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Divider(height: 4.0),
              trackerUpdate.trackingState == TrackingState.paused
                  ? _buildTile(
                      label: 'RESUME',
                      color: Colors.teal,
                      icon: CommunityMaterialIcons.play_circle_outline,
                      onTap: () => context.repository<TrackerBloc>().add(
                            const TrackingResumed(),
                          ),
                    )
                  : _buildTile(
                      label: 'PAUSE',
                      color: Colors.blue,
                      icon: CommunityMaterialIcons.pause_circle_outline,
                      onTap: () => context.repository<TrackerBloc>().add(
                            const TrackingPaused(),
                          ),
                    ),
              _buildTile(
                label: 'STOP',
                color: Colors.red,
                icon: CommunityMaterialIcons.stop_circle_outline,
                onTap: () => context.repository<TrackerBloc>().add(
                      const TrackingStopped(),
                    ),
              ),
            ],
          );
  }

  Widget _buildTile({
    Color color,
    String label,
    IconData icon,
    VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        size: 24.0,
        color: color,
      ),
      title: Text(
        label,
        style: AppTextStyles.small.bold.copyWith(color: color),
      ),
    );
  }
}
