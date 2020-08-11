import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';

class TrackerFab extends StatelessWidget {
  const TrackerFab();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationCubit>().destination;

    return FloatingActionButton(
      backgroundColor: AppColors.dark,
      child: const Icon(
        Icons.directions_walk,
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
