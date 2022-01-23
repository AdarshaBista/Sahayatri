import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/appbars/curved_appbar.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/drawer_icon.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/tracker_fab.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/bottom_navbar.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/destination_drawer.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/places_list.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itineraries_list.dart';

class DestinationDetailPage extends StatefulWidget {
  const DestinationDetailPage();

  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ZoomDrawerController drawerController;

  @override
  void initState() {
    super.initState();
    drawerController = ZoomDrawerController();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => drawerController.close?.call(),
      onPanUpdate: (details) {
        if (details.delta.dx < -6.0) drawerController.open?.call();
        if (details.delta.dx > 6.0) drawerController.close?.call();
      },
      child: ZoomDrawer(
        angle: 0.0,
        showShadow: true,
        borderRadius: 24.0,
        controller: drawerController,
        closeCurve: Curves.easeInOut,
        openCurve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: context.c.background.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.45,
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
        child: BottomNavbar(tabController: tabController),
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
      actions: const [DrawerIcon()],
      leading: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.keyboard_backspace, size: 20.0),
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: tabController,
      physics: const BouncingScrollPhysics(),
      children: const [
        PlacesList(),
        ItinerariesList(),
      ],
    );
  }
}
