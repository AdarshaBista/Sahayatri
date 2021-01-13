import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/nearby/nearby_form.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/common/bottom_nav_bar.dart';
import 'package:sahayatri/ui/widgets/views/animated_tab_view.dart';
import 'package:sahayatri/ui/widgets/translate/translate_form.dart';
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
          child: AnimatedTabView(
            keepAlive: true,
            index: _selectedIndex,
            children: const [
              ProgressTab(),
              TranslateForm(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: NearbyForm(),
              ),
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
              AppIcons.progress,
              AppIcons.translate,
              AppIcons.nearby,
            ],
          ),
        ),
      ],
    );
  }
}
