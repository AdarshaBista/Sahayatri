import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/shared/widgets/close_icon.dart';
import 'package:sahayatri/ui/pages/route_page/widgets/route_map.dart';

class RoutePage extends StatelessWidget {
  final List<Place> places;

  const RoutePage({
    @required this.places,
  }) : assert(places != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          RouteMap(places: places),
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
