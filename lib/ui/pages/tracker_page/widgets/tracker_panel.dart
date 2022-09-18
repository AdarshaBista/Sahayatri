import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/location_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/tracker_map.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_tabs.dart';
import 'package:sahayatri/ui/widgets/common/drag_indicator_pill.dart';
import 'package:sahayatri/ui/widgets/common/sliding_panel.dart';

class TrackerPanel extends StatefulWidget {
  const TrackerPanel({super.key});

  @override
  State<TrackerPanel> createState() => _TrackerPanelState();
}

class _TrackerPanelState extends State<TrackerPanel> {
  double panelOpenPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    final margin = (1.0 - panelOpenPercent) * 16.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingPanel(
        minHeight: 90.0,
        borderRadius: 16.0,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        margin: EdgeInsets.all(margin),
        body: const TrackerMap(),
        panel: _buildPanel(),
        onPanelSlide: (value) {
          setState(() {
            panelOpenPercent = value;
          });
        },
      ),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: const [
        SizedBox(height: 4.0),
        DragIndicatorPill(),
        LocationStats(),
        SizedBox(height: 12.0),
        Divider(indent: 20.0, endIndent: 20.0, height: 1.0),
        Expanded(child: TrackerTabs()),
      ],
    );
  }
}
