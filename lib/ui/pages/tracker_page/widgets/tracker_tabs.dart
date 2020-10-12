import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/bottom_nav_bar.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/nearby_tab.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/translate_tab.dart';
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
              TranslateTab(),
              NearbyTab(),
            ],
          ),
        ),
        ElevatedCard(
          radius: 12.0,
          padding: const EdgeInsets.only(top: 8.0),
          child: BottomNavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            icons: const [
              CommunityMaterialIcons.progress_clock,
              CommunityMaterialIcons.translate,
              CommunityMaterialIcons.access_point_network,
            ],
          ),
        ),
      ],
    );
  }
}
