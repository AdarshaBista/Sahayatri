import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';

class TrackerFab extends StatelessWidget {
  const TrackerFab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          return _buildFab(context);
        }
        return const Offstage();
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.dark,
      child: const Icon(
        Icons.play_arrow_outlined,
        size: 24.0,
        color: AppColors.primary,
      ),
      onPressed: () {
        if (destination.createdItinerary == null) {
          const MessageDialog(
            message: 'You must create an itinerary before starting tracker.',
          ).openDialog(context);
          return;
        }

        context.repository<DestinationNavService>().pushNamed(
              Routes.kTrackerPageRoute,
              arguments: context.bloc<DestinationCubit>().destination,
            );
      },
    );
  }
}
