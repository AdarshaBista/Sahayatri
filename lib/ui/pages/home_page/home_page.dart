import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/common/bottom_nav_bar.dart';

import 'package:sahayatri/ui/pages/profile_page/profile_page.dart';
import 'package:sahayatri/ui/pages/downloaded_page/downloaded_page.dart';
import 'package:sahayatri/ui/pages/destinations_page/destinations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DestinationsCubit>(
          create: (context) => DestinationsCubit(
            destinationsService: context.read<DestinationsService>(),
          )..fetchDestinations(),
        ),
        BlocProvider<DownloadedDestinationsCubit>(
          lazy: false,
          create: (context) => DownloadedDestinationsCubit(
            destinationsService: context.read<DestinationsService>(),
          )..fetchDownloaded(),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavBar(
          iconSize: 22.0,
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          icons: const [
            CommunityMaterialIcons.map_marker_circle,
            CommunityMaterialIcons.check_circle_outline,
            CommunityMaterialIcons.account_circle_outline,
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            DestinationsPage(),
            DownloadedPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
