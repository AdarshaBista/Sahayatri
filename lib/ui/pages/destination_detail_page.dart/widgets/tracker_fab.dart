import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';

class TrackerFab extends StatelessWidget {
  const TrackerFab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserItineraryCubit, UserItineraryState>(
      builder: (context, state) {
        if (state is UserItineraryLoaded) {
          return _buildFab(context);
        }
        return const Offstage();
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return MiniFab(
      icon: Icons.play_arrow_outlined,
      onTap: () {
        final destination = context.read<Destination>();
        context.read<DestinationNavService>().pushNamed(
              Routes.trackerPageRoute,
              arguments: destination,
            );
      },
    );
  }
}
