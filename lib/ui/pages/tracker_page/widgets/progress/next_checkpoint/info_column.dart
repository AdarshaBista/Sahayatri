import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/tracker_update.dart';
import 'package:sahayatri/core/utils/format_utils.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/info_card.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;
    if (nextCheckpoint == null) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoCard(
          color: Colors.red,
          icon: AppIcons.distance,
          title: FormatUtils.distance(nextCheckpoint.distance),
          subtitle: 'Away',
        ),
        const SizedBox(height: 12.0),
        InfoCard(
          color: Colors.green,
          icon: AppIcons.eta,
          title: nextCheckpoint.eta == null
              ? 'N/A'
              : _formatDuration(nextCheckpoint.eta!),
          subtitle: 'ETA',
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    return '${duration.inHours} hr ${duration.inMinutes.remainder(60)} min';
  }
}
