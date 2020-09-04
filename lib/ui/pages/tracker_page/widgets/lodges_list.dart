import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/lodge_card.dart';

class LodgesList extends StatelessWidget {
  final String title;
  final List<Lodge> lodges;

  const LodgesList({
    @required this.lodges,
    this.title = 'Lodges',
  })  : assert(title != null),
        assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppTextStyles.small.bold),
        const SizedBox(height: 12.0),
        Container(
          height: 160.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: lodges.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 0.8,
                child: LodgeCard(lodge: lodges[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
