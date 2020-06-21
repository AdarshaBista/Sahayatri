import 'package:flutter/material.dart';

import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_stats.dart';

class TrackerPanel extends StatelessWidget {
  final TrackerSuccess state;
  final double collapsedHeight;
  final ScrollController controller;

  const TrackerPanel({
    @required this.state,
    @required this.controller,
    @required this.collapsedHeight,
  })  : assert(state != null),
        assert(controller != null),
        assert(collapsedHeight != null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          const Pill(),
          TrackerStats(
            height: collapsedHeight,
            userLocation: state.userLocation,
          ),
          const Divider(height: 20.0),
        ],
      ),
    );
  }
}
