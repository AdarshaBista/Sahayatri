import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/column_button.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';

class DirectionsButton extends StatelessWidget {
  final String label;

  const DirectionsButton({
    this.label = 'Get Directions',
  }) : assert(label != null);

  List<_DirectionsModeData> get _directionsModesData => [
        const _DirectionsModeData(
          title: 'Drive',
          // mode: NavigationMode.driving,
          icon: CommunityMaterialIcons.car,
        ),
        const _DirectionsModeData(
          title: 'Cycle',
          // mode: NavigationMode.cycling,
          icon: CommunityMaterialIcons.bike,
        ),
        const _DirectionsModeData(
          title: 'Walk',
          // mode: NavigationMode.walking,
          icon: CommunityMaterialIcons.hiking,
        ),
      ];

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
        outlineOnly: true,
        color: context.c.onSurface,
        backgroundColor: context.c.onSurface,
        iconData: Icons.directions_outlined,
        onTap: () => _buildModesRow(context).openModalBottomSheet(context),
      ),
    );
  }

  Widget _buildModesRow(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _directionsModesData
            .map(
              (m) => ColumnButton(
                label: m.title,
                icon: m.icon,
                onTap: () {
                  Navigator.of(context).pop();
                  final directionsCubit = context.read<DirectionsCubit>();
                  final destination = context.read<DestinationCubit>().destination;
                  directionsCubit.startNavigation(
                    destination.name,
                    destination.route.first,
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DirectionsModeData {
  final String title;
  final IconData icon;
  // final NavigationMode mode;

  const _DirectionsModeData({
    @required this.title,
    @required this.icon,
    // @required this.mode,
  })  : assert(title != null),
        assert(icon != null);
  // assert(mode != null);
}
