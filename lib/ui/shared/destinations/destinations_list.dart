import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/destinations/destination_card.dart';

class DestinationsList extends StatelessWidget {
  final AsyncCallback onRefresh;
  final List<Destination> destinations;

  const DestinationsList({
    @required this.onRefresh,
    @required this.destinations,
  })  : assert(onRefresh != null),
        assert(destinations != null);

  @override
  Widget build(BuildContext context) {
    return destinations.isEmpty
        ? EmptyIndicator(
            message: 'No destinations found',
            onRetry: () => context.bloc<DestinationsCubit>().fetchDestinations(),
          )
        : RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: destinations.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => SlideAnimator(
                begin: Offset(0.0, 0.2 + index * 0.4),
                child: DestinationCard(
                  destination: destinations[index],
                ),
              ),
            ),
          );
  }
}
