import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/extensions/flushbar_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class DirectionsButton extends StatelessWidget {
  final String label;

  const DirectionsButton({
    this.label = 'Get Directions',
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DirectionsCubit, DirectionsState>(
      listener: (context, state) {
        if (state is DirectionsError) {
          context.openFlushBar(state.message, type: FlushbarType.error);
        }
        if (state is DirectionsLoading) {
          context.openFlushBar('Loading Directions. Please wait...');
        }
      },
      child: CustomButton(
        label: label,
        outline: true,
        color: context.c.onSurface,
        icon: AppIcons.directions,
        onTap: () => const _NavigationModeSheet().openModalBottomSheet(context),
      ),
    );
  }
}

class _NavigationModeSheet extends StatelessWidget {
  const _NavigationModeSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'Select mode',
            fontSize: 20.0,
          ),
          const SizedBox(height: 12.0),
          CustomButton(
            label: 'DRIVE',
            icon: AppIcons.drive,
            onTap: () => startNavigation(context, DirectionsMode.drive),
          ),
          const SizedBox(height: 8.0),
          CustomButton(
            label: 'CYCLE',
            icon: AppIcons.cycle,
            onTap: () => startNavigation(context, DirectionsMode.cycle),
          ),
          const SizedBox(height: 8.0),
          CustomButton(
            label: 'WALK',
            icon: AppIcons.walk,
            onTap: () => startNavigation(context, DirectionsMode.walk),
          ),
        ],
      ),
    );
  }

  Future<void> startNavigation(BuildContext context, String mode) async {
    Navigator.of(context).pop();
    final destination = context.read<Destination>();
    final directionsCubit = context.read<DirectionsCubit>();
    directionsCubit.startNavigation(destination.route.first, mode);
  }
}
