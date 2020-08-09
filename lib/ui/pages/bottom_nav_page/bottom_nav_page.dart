import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/widgets/splash_view.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/widgets/bottom_nav_bar.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/settings_page/settings_page.dart';
import 'package:sahayatri/ui/pages/destinations_page/destinations_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage();

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        if (state is PrefsLoading) {
          return const SplashView();
        }
        return _buildNavView();
      },
    );
  }

  Widget _buildNavView() {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        icons: const [
          CommunityMaterialIcons.map_search_outline,
          CommunityMaterialIcons.check_circle_outline,
          CommunityMaterialIcons.account_outline,
          CommunityMaterialIcons.cog_outline,
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DestinationsPage(),
          Offstage(),
          AuthPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
