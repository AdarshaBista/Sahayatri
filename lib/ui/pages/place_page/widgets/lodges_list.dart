import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/destination/lodge_card.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';

class LodgesList extends StatelessWidget {
  const LodgesList({super.key});

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context, listen: false);
    final lodges = place.lodges;

    return lodges.isEmpty
        ? const EmptyIndicator(message: 'No lodges found.')
        : _buildList(lodges);
  }

  Widget _buildList(List<Lodge> lodges) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
    );
  }
}
