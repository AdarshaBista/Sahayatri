import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/pill.dart';
import 'package:sahayatri/ui/shared/widgets/sliding_panel.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/location_stats.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/tracker_map.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/progress_tab.dart';

class TrackerPanel extends StatelessWidget {
  static const double kCollapsedHeight = 100.0;

  const TrackerPanel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingPanel(
        snapPoint: 0.7,
        parallaxEnabled: false,
        minHeight: kCollapsedHeight,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        margin: const EdgeInsets.all(12.0),
        body: const TrackerMap(),
        panelBuilder: (sc) => _buildPanel(sc),
      ),
    );
  }

  Widget _buildPanel(ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 4.0),
          const Pill(),
          const LocationStats(height: kCollapsedHeight),
          const Divider(height: 20.0),
          NestedTabView(
            tabBarMargin: EdgeInsets.zero,
            tabBarPadding: const EdgeInsets.only(bottom: 16.0),
            tabs: [
              NestedTabData(
                label: 'Progress',
                icon: CommunityMaterialIcons.progress_clock,
              ),
              NestedTabData(
                label: 'Analytics',
                icon: CommunityMaterialIcons.home_analytics,
              ),
              NestedTabData(
                label: 'Network',
                icon: CommunityMaterialIcons.access_point_network,
              ),
            ],
            children: [
              const ProgressTab(),
              Container(),
              Container(),
            ],
          ),
        ],
      ),
    );
  }
}
