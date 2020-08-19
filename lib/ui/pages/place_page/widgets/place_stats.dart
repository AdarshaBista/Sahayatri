import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/stat_tile.dart';

class PlaceStats extends StatelessWidget {
  const PlaceStats();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          StatTile(
            label: 'Altitude',
            stat: '${place.coord.alt.floor()} m',
            icon: CommunityMaterialIcons.altimeter,
          ),
          StatTile(
            label: 'Network',
            stat: place.isNetworkAvailable ? 'Yes' : 'No',
            icon: CommunityMaterialIcons.antenna,
          ),
        ],
      ),
    );
  }
}
