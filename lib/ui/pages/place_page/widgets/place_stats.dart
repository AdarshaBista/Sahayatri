import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class PlaceStats extends StatelessWidget {
  const PlaceStats();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Altitude',
            count: '${place.coord.alt.floor()} m',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Lodges',
            count: place.lodges.length.toString(),
            color: Colors.teal,
          ),
          StatCard(
            label: 'Network',
            count: place.isNetworkAvailable ? 'Yes' : 'No',
            color: place.isNetworkAvailable ? Colors.teal : Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
