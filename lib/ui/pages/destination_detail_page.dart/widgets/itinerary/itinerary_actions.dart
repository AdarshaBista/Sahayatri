import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/tracker/tracker_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/widgets/dialogs/message_dialog.dart';

class ItineraryActions extends StatelessWidget {
  final bool deletable;
  final Itinerary itinerary;

  const ItineraryActions({
    @required this.deletable,
    @required this.itinerary,
  })  : assert(deletable != null),
        assert(itinerary != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0)),
      ),
      child: _buildButtons(context),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildIcon(
          color: AppColors.primaryDark,
          icon: Icons.edit,
          onTap: () => context.read<DestinationNavService>().pushNamed(
            Routes.itineraryFormPageRoute,
            arguments: [
              itinerary,
              context.read<UserItineraryCubit>(),
            ],
          ),
        ),
        if (deletable)
          _buildIcon(
            color: AppColors.secondary,
            icon: Icons.close,
            onTap: () {
              if (context.read<TrackerService>().isTracking) {
                const MessageDialog(
                  message: 'Cannot delete when tracker is running.',
                ).openDialog(context);
                return;
              }
              ConfirmDialog(
                message: 'Do you want to delete this itinerary?',
                onConfirm: () => context.read<UserItineraryCubit>().deleteItinerary(),
              ).openDialog(context);
            },
          ),
      ],
    );
  }

  Widget _buildIcon({Color color, IconData icon, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.0,
        height: 32.0,
        color: color,
        child: Icon(
          icon,
          size: 16.0,
          color: AppColors.light,
        ),
      ),
    );
  }
}
