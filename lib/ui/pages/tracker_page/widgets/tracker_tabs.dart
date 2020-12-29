import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/bottom_nav_bar.dart';
import 'package:sahayatri/ui/widgets/common/animated_child_view.dart';
import 'package:sahayatri/ui/widgets/translate/translate_form.dart';
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
          child: AnimatedChildView(
            keepAlive: true,
            index: _selectedIndex,
            children: const [
              ProgressTab(),
              TranslateForm(isOnSettings: false),
              NearbyTab(),
            ],
          ),
        ),
        ElevatedCard(
          radius: 0.0,
          elevation: 4.0,
          child: BottomNavBar(
            iconSize: 20.0,
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
