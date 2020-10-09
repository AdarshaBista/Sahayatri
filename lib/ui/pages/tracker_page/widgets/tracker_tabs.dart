import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/bottom_nav_bar.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/nearby_tab.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/progress_tab.dart';

class TrackerTabs extends StatefulWidget {
  const TrackerTabs();

  @override
  _TrackerTabsState createState() => _TrackerTabsState();
}

class _TrackerTabsState extends State<TrackerTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: const [
              ProgressTab(),
              NearbyTab(),
            ],
          ),
        ),
        BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          icons: const [
            CommunityMaterialIcons.progress_clock,
            CommunityMaterialIcons.access_point_network,
          ],
        ),
      ],
    );
  }
}
