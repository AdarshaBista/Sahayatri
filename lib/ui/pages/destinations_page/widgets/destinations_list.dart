import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/destinations_page/widgets/destination_card.dart';

class DestinationsList extends StatelessWidget {
  final List<Destination> destinations;

  const DestinationsList({
    @required this.destinations,
  }) : assert(destinations != null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      itemBuilder: (context, index) => SlideAnimator(
        begin: Offset(0.0, 10.0 + index * 20.0),
        child: DestinationCard(
          destination: destinations[index],
        ),
      ),
    );
  }
}
