import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/pages/place_page/widgets/lodge_card.dart';

class LodgesGrid extends StatelessWidget {
  const LodgesGrid();

  @override
  Widget build(BuildContext context) {
    final lodges = Provider.of<Place>(context).lodges;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 10 / 13,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      itemCount: lodges.length,
      itemBuilder: (context, index) {
        return LodgeCard(lodge: lodges[index]);
      },
    );
  }
}
