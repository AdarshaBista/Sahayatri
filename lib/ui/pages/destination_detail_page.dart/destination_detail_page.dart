import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/shared/widgets/nested_tab_view.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NestedTabData> get _tabs => [
        NestedTabData(
            label: 'Itinerary', icon: CommunityMaterialIcons.map_search),
        NestedTabData(
            label: 'Places', icon: CommunityMaterialIcons.map_marker_radius),
      ];

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Scaffold(
      extendBody: true,
      appBar: CustomAppbar(
        elevation: 4.0,
        title: destination.name,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8.0,
        notchMargin: 6.0,
        color: AppColors.background,
        shape: const CircularNotchedRectangle(),
        child: _buildBottomNavBar(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
      body: _buildTabViews(),
    );
  }

  FloatingActionButton _buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.dark,
      onPressed: () => context.repository<DestinationNavService>().pushNamed(
            Routes.kTrackerPageRoute,
            arguments:
                context.bloc<DestinationBloc>().destination.startingPlace.coord,
          ),
      child: const Icon(
        Icons.directions_walk,
        size: 24.0,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 50.0,
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(color: Colors.transparent),
          tabs: [
            for (int i = 0; i < _tabs.length; ++i)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: NestedTab(
                  tab: _tabs[i],
                  color: _tabController.index == i
                      ? AppColors.primary
                      : AppColors.dark,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ItinerariesList(),
        PlacesGrid(),
      ],
    );
  }
}
