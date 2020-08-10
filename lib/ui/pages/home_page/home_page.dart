import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/bottom_nav_bar.dart';

import 'package:sahayatri/ui/pages/settings_page/settings_page.dart';
import 'package:sahayatri/ui/pages/profile_page/profile_page.dart';
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
          CommunityMaterialIcons.account_circle_outline,
          CommunityMaterialIcons.cog_outline,
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DestinationsPage(),
          Offstage(),
          ProfilePage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
