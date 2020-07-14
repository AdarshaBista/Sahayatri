import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/setup/setup_tab.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/widgets/bottom_nav_bar.dart';
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
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        icons: const [
          CommunityMaterialIcons.progress_clock,
          CommunityMaterialIcons.cog_outline,
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ProgressTab(),
          SetupTab(),
        ],
      ),
    );
  }
}
