import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/format_utils.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/info_card.dart';

class InfoColumn extends StatelessWidget {
  const InfoColumn();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;
    if (nextCheckpoint == null) return const Offstage();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoCard(
          icon: Icons.timeline,
          title: FormatUtils.distance(nextCheckpoint.distance),
          subtitle: 'Away',
        ),
        const SizedBox(height: 12.0),
        InfoCard(
          icon: Icons.av_timer_outlined,
          title: nextCheckpoint.eta == null ? 'N/A' : _formatDuration(nextCheckpoint.eta),
          subtitle: 'ETA',
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    return '${duration.inHours} hr ${duration.inMinutes.remainder(60)} min';
  }
}
