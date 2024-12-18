import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/images.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/destination/destination_card.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';

class DestinationsList extends StatelessWidget {
  final bool deletable;
  final bool isSearching;
  final List<Destination> destinations;

  const DestinationsList({
    super.key,
    this.deletable = false,
    required this.isSearching,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) {
      if (isSearching) {
        return const EmptyIndicator(
          imageUrl: Images.searchEmpty,
          message: 'No results found.',
        );
      }

      return const EmptyIndicator();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: destinations.length,
      physics: deletable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
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
