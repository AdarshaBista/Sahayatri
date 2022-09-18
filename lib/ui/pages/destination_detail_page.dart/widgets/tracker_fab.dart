import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';

import 'package:sahayatri/locator.dart';

class TrackerFab extends StatelessWidget {
  const TrackerFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserItineraryCubit, UserItineraryState>(
      builder: (context, state) {
        if (state is UserItineraryLoaded) {
          return _buildFab(context, state.userItinerary);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFab(BuildContext context, Itinerary itinerary) {
    return MiniFab(
      icon: AppIcons.track,
      onTap: () {
        final destination = context.read<Destination>();
        context.read<TrackerCubit>().attemptTracking(destination, itinerary);
        locator<DestinationNavService>().pushNamed(Routes.trackerPageRoute);
      },
    );
  }
}
