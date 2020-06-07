import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodge_card.dart';

class LodgesGrid extends StatelessWidget {
  const LodgesGrid();

  @override
  Widget build(BuildContext context) {
    final lodges = Provider.of<Place>(context).lodges;

    return FadeAnimator(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10 / 13,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        itemCount: lodges.length,
        itemBuilder: (context, index) {
          return LodgeCard(lodge: lodges[index]);
        },
      ),
    );
  }
}
