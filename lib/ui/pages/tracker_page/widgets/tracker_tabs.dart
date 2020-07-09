import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/widgets/bottom_nav_bar.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/progress/progress_tab.dart';

class TrackerTabs extends StatefulWidget {
  final ScrollController controller;

  const TrackerTabs({
    @required this.controller,
  }) : assert(controller != null);

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
          CommunityMaterialIcons.google_analytics,
          CommunityMaterialIcons.access_point_network,
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ProgressTab(controller: widget.controller),
          const Offstage(),
          const Offstage(),
        ],
      ),
    );
  }
}
