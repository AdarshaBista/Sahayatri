import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/checkpoint_lodges.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/info_column.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/checkpoint_info.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/next_checkpoint/checkpoint_place.dart';

class NextCheckpointCard extends StatelessWidget {
  const NextCheckpointCard();

  @override
  Widget build(BuildContext context) {
    final nextCheckpoint = context.watch<TrackerUpdate>().nextCheckpoint;
    if (nextCheckpoint == null) return const Offstage();
    final lodges = nextCheckpoint.checkpoint.place.lodges;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'NEXT CHECKPOINT',
            style: context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        const CheckpointPlace(),
        const SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: const [
              Expanded(flex: 2, child: InfoColumn()),
              SizedBox(width: 12.0),
              Expanded(flex: 3, child: CheckpointInfo()),
            ],
          ),
        ),
        if (lodges.isNotEmpty) ...[
          const SizedBox(height: 20.0),
          CheckpointLodges(lodges: lodges),
        ],
      ],
    );
  }
}
