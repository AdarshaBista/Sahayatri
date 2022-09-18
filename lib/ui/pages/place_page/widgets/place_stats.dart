import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_tile.dart';

class PlaceStats extends StatelessWidget {
  const PlaceStats({super.key});

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: <Widget>[
          StatTile(
            label: 'Altitude',
            stat: '${place.coord.alt.floor()} m',
            icon: AppIcons.altitude,
          ),
          StatTile(
            label: 'Cell Network',
            stat: place.isNetworkAvailable ? 'Yes' : 'No',
            icon: AppIcons.network,
          ),
        ],
      ),
    );
  }
}
