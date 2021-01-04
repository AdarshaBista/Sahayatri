import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/lodge_card.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class LodgesList extends StatelessWidget {
  final List<Lodge> lodges;

  const LodgesList({
    @required this.lodges,
  }) : assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lodges', style: context.t.headline3),
        const SizedBox(height: 12.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemExtent: 100.0,
          itemCount: lodges.length,
          itemBuilder: (context, index) {
            return SlideAnimator(
              duration: (index + 1) * 150,
              begin: const Offset(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: LodgeCard(lodge: lodges[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
