import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/column_button.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/custom_button.dart';

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
          _showSnackBar(context, state.message);
        }
        if (state is DirectionsLoading) {
          _showSnackBar(context, 'Loading Directions. Please wait...');
        }
      },
      child: CustomButton(
        label: label,
        outlineOnly: true,
        color: AppColors.dark,
        iconData: CommunityMaterialIcons.directions,
        onTap: () => _buildModesRow(context).openModalBottomSheet(context),
      ),
    );
  }

  Widget _buildModesRow(BuildContext context) {
    return Container(
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
                  context.bloc<DirectionsCubit>().startNavigation(
                        context.bloc<DestinationCubit>().destination.startingPlace,
                      );
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
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
