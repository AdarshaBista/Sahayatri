import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/custom_map.dart';
import 'package:sahayatri/ui/widgets/dialogs/map_dialog.dart';

class UpdateMapDialog extends StatelessWidget {
  final List<Coord> coords;

  const UpdateMapDialog({this.coords});

  @override
  Widget build(BuildContext context) {
    if (coords != null) {
      return _buildMapDialog(
        center: coords.first,
        effectiveCoords: coords,
      );
    }

    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        final center = state.coords.isNotEmpty
            ? state.coords.first
            : context.watch<Destination>().midPointCoord;

        return _buildMapDialog(
          center: center,
          effectiveCoords: state.coords,
          onTap: (coord) =>
              context.read<DestinationUpdateFormCubit>().updateCoords(coord),
        );
      },
    );
  }

  Widget _buildMapDialog({
    Coord center,
    Function(Coord) onTap,
    List<Coord> effectiveCoords,
  }) {
    return MapDialog(
      map: CustomMap(
        onTap: onTap,
        center: center,
        initialZoom: 17.0,
        children: [
          if (effectiveCoords.isNotEmpty)
            _MarkersLayer(
              onTap: onTap,
              coords: effectiveCoords,
            ),
        ],
      ),
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  final List<Coord> coords;
  final Function(Coord) onTap;

  const _MarkersLayer({
    this.onTap,
    @required this.coords,
  }) : assert(coords != null);

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: coords.map((c) => _buildMarker(c)).toList(),
      ),
    );
  }

  Marker _buildMarker(Coord c) {
    const double size = 24.0;

    return Marker(
      width: size,
      height: size,
      point: c.toLatLng(),
      builder: (context) {
        return GestureDetector(
          onTap: () => onTap(c),
          child: const Icon(
            AppIcons.updateMarker,
            size: size,
            color: AppColors.secondary,
          ),
        );
      },
    );
  }
}
