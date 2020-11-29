import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/curved_appbar.dart';
import 'package:sahayatri/ui/widgets/common/nested_tab_view.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/drawer_icon.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/tracker_fab.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/destination_drawer.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/places_grid.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itineraries_list.dart';

class DestinationDetailPage extends StatefulWidget {
  const DestinationDetailPage();

  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ZoomDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = ZoomDrawerController();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NestedTabData> get _tabs => [
        NestedTabData(
          label: 'Places',
          icon: CommunityMaterialIcons.map_marker_radius_outline,
        ),
        NestedTabData(
          label: 'Itinerary',
          icon: CommunityMaterialIcons.book_outline,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _drawerController.close(),
      onPanUpdate: (details) {
        if (details.delta.dx > 6.0) _drawerController.open();
        if (details.delta.dx < -6.0) _drawerController.close();
      },
      child: ZoomDrawer(
        angle: 0.0,
        showShadow: true,
        borderRadius: 24.0,
        controller: _drawerController,
        closeCurve: Curves.easeInOut,
        openCurve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: context.c.background.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        mainScreen: _buildPage(),
        menuScreen: const DestinationDrawer(),
      ),
    );
  }

  Widget _buildPage() {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomAppBar(
        elevation: 8.0,
        notchMargin: 6.0,
        color: context.theme.cardColor,
        child: _buildBottomNavBar(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const TrackerFab(),
      body: _buildTabViews(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final name = context.watch<Destination>().name;

    return CurvedAppbar(
      title: name,
      elevation: 0.0,
      leading: const DrawerIcon(),
      actions: [
        IconButton(
          splashRadius: 20.0,
          icon: const Icon(Icons.home_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
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
          controller: _tabController,
          indicator: const BoxDecoration(color: Colors.transparent),
          tabs: [
            for (int i = 0; i < _tabs.length; ++i)
              NestedTab(
                tab: _tabs[i],
                color: _tabController.index == i
                    ? AppColors.primary
                    : context.c.onBackground,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        PlacesGrid(),
        ItinerariesList(),
      ],
    );
  }
}
