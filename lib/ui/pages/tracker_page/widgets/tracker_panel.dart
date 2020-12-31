import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/widgets/common/sliding_panel.dart';
import 'package:sahayatri/ui/widgets/common/drag_indicator_pill.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/tracker_tabs.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/location_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/tracker_map.dart';

class TrackerPanel extends StatefulWidget {
  const TrackerPanel();

  @override
  _TrackerPanelState createState() => _TrackerPanelState();
}

class _TrackerPanelState extends State<TrackerPanel> {
  double panelOpenPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    final margin = (1.0 - panelOpenPercent) * 16.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingPanel(
        margin: EdgeInsets.all(margin),
        minHeight: UiConfig.trackerPanelHeight,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
