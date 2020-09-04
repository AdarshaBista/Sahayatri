import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/lodges_list.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/tracker_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        const TrackerStats(),
        const SizedBox(height: 12.0),
        const NextCheckpointCard(),
        const SizedBox(height: 16.0),
        _buildLodgesList(context),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildLodgesList(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;
    if (nextCheckpoint == null) return const Offstage();
    final lodges = nextCheckpoint.checkpoint.place.lodges;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: LodgesList(
        lodges: lodges,
        title: 'Upcoming Lodges',
      ),
    );
  }
}
