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
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: <Widget>[
          StatTile(
            label: 'Altitude',
            stat: '${place.coord.alt.floor()} m',
            icon: CommunityMaterialIcons.altimeter,
          ),
          StatTile(
            label: 'Cell Network',
            stat: place.isNetworkAvailable ? 'Yes' : 'No',
            icon: CommunityMaterialIcons.antenna,
          ),
        ],
      ),
    );
  }
}
