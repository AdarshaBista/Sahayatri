import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';

class SelectLocationDialog extends StatelessWidget {
  const SelectLocationDialog();

  @override
  Widget build(BuildContext context) {
    return MapDialog(
      map: BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
        builder: (context, state) {
          final center = state.coords.isNotEmpty
              ? state.coords.first
              : context.watch<DestinationCubit>().destination.midPointCoord;

          return CustomMap(
            center: center,
            initialZoom: 17.0,
            children: [if (state.coords.isNotEmpty) const _MarkersLayer()],
            onTap: (coord) =>
                context.read<DestinationUpdateFormCubit>().updateCoords(coord),
          );
        },
      ),
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  const _MarkersLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        return MarkerLayerWidget(
          options: MarkerLayerOptions(
            markers: state.coords.map((c) => _buildMarker(context, c)).toList(),
          ),
        );
      },
    );
  }

  Marker _buildMarker(BuildContext context, Coord c) {
    const double size = 24.0;

    return Marker(
      width: size,
      height: size,
      point: c.toLatLng(),
      builder: (context) {
        return GestureDetector(
          onTap: () => context.read<DestinationUpdateFormCubit>().updateCoords(c),
          child: const Icon(
            CommunityMaterialIcons.circle_double,
            size: size,
            color: AppColors.secondary,
          ),
        );
      },
    );
  }
}
