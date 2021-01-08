import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';

class BottomNavbar extends StatelessWidget {
  final TabController tabController;

  const BottomNavbar({
    @required this.tabController,
  }) : assert(tabController != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: TabBar(
          controller: tabController,
          indicator: const BoxDecoration(color: Colors.transparent),
          tabs: [
            for (int i = 0; i < _tabs.length; ++i)
              NestedTab(
                tab: _tabs[i],
                showIndicator: false,
                isSelected: tabController.index == i,
              ),
          ],
        ),
      ),
    );
  }

  List<NestedTabData> get _tabs => [
        NestedTabData(
          label: 'Places',
          icon: AppIcons.places,
        ),
        NestedTabData(
          label: 'Itinerary',
          icon: AppIcons.itineraries,
        ),
      ];
}
