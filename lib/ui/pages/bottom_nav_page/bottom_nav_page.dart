import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/widgets/bottom_nav_bar.dart';

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
        icons: [
          CommunityMaterialIcons.map_marker_outline,
          CommunityMaterialIcons.home_outline,
          CommunityMaterialIcons.account_outline,
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          DestinationsPage(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
