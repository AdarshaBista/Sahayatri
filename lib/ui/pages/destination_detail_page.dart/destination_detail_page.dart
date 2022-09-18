import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/bottom_navbar.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itineraries_list.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/places_list.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/tracker_fab.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/appbars/curved_appbar.dart';

class DestinationDetailPage extends StatefulWidget {
  const DestinationDetailPage({super.key});

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
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
