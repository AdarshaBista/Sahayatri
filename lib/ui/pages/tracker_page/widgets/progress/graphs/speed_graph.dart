import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/tracker_update.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/graphs/tracker_graph.dart';

class SpeedGraph extends StatelessWidget {
  const SpeedGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final userTrack = context.watch<TrackerUpdate>().userTrack;
    final speeds =
        userTrack.map((u) => double.parse(u.speed.toStringAsFixed(1))).toList();

    return TrackerGraph(
      yValues: speeds,
      color: Colors.blue,
      title: 'RECENT SPEED HISTORY',
    );
  }
}
