import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/pages/route_page/widgets/route_map.dart';

class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const RouteMap(),
          const Positioned(
            top: 16.0,
            right: 16.0,
            child: SafeArea(child: CloseIcon()),
          ),
        ],
      ),
    );
  }
}
