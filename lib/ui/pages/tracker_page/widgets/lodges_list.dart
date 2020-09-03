import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/place_page/widgets/lodge_card.dart';

class LodgesList extends StatelessWidget {
  final List<Lodge> lodges;

  const LodgesList({
    @required this.lodges,
  }) : assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    if (lodges.isEmpty) return const Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lodges', style: AppTextStyles.small.bold),
        const SizedBox(height: 12.0),
        Container(
          height: 180.0,
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
