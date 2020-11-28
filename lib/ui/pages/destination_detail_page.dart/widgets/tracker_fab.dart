import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/message_dialog.dart';

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
    return BlocBuilder<DestinationCubit, Destination>(
      builder: (context, destination) {
        return FloatingActionButton(
          mini: true,
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

            context.read<DestinationNavService>().pushNamed(
                  Routes.trackerPageRoute,
                  arguments: context.read<DestinationCubit>().destination,
                );
          },
        );
      },
    );
  }
}
