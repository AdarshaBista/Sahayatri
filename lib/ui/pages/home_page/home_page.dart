import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/ui/pages/destinations_page/destinations_page.dart';
import 'package:sahayatri/ui/pages/downloaded_page/downloaded_page.dart';
import 'package:sahayatri/ui/pages/profile_page/profile_page.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/bottom_nav_bar.dart';
import 'package:sahayatri/ui/widgets/views/animated_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<DestinationsCubit>(
              create: (context) => DestinationsCubit()..fetchDestinations(),
            ),
            if (state is Authenticated)
              BlocProvider<DownloadedDestinationsCubit>(
                lazy: false,
                create: (context) => DownloadedDestinationsCubit()..fetchDownloaded(),
              ),
          ],
          child: _buildPage(),
        );
      },
    );
  }

  Widget _buildPage() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavBar(
        iconSize: 24.0,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        icons: const [
          AppIcons.destinations,
          AppIcons.downloaded,
          AppIcons.profile,
        ],
      ),
      body: AnimatedTabView(
        keepAlive: true,
        index: _selectedIndex,
        children: const [
          DestinationsPage(),
          DownloadedPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
