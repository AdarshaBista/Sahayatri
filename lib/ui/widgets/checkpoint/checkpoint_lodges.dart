import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/destination/lodge_card.dart';

class CheckpointLodges extends StatelessWidget {
  final List<Lodge> lodges;

  const CheckpointLodges({
    @required this.lodges,
  }) : assert(lodges != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'UPCOMING LODGES',
            style: context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 80.0,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            separatorBuilder: (_, __) => const SizedBox(width: 12.0),
            itemCount: lodges.length,
            itemBuilder: (_, index) {
              return SizedBox(
                width: 180.0,
                child: LodgeCard(lodge: lodges[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
