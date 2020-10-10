import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/destinations/destination_card.dart';

class DestinationsList extends StatelessWidget {
  final bool deletable;
  final List<Destination> destinations;

  const DestinationsList({
    this.deletable = false,
    @required this.destinations,
  })  : assert(deletable != null),
        assert(destinations != null);

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) return const EmptyIndicator();

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: destinations.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SlideAnimator(
        begin: Offset(0.0, 0.2 + index * 0.4),
        child: DestinationCard(
          deletable: deletable,
          destination: destinations[index],
        ),
      ),
    );
  }
}
