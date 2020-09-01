import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodge_card.dart';

class LodgesGrid extends StatelessWidget {
  const LodgesGrid();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);
    final lodges = place.lodges;

    return lodges.isEmpty
        ? const EmptyIndicator(
            message: 'No lodges found.',
          )
        : GridView.builder(
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
