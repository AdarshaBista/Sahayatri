import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/destination_update_post_cubit/destination_update_post_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/map/custom_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class SelectLocationDialog extends StatelessWidget {
  const SelectLocationDialog();

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.light,
        title: _buildMap(context),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<DestinationUpdatePostCubit, DestinationUpdatePostState>(
      builder: (context, state) {
        final center = state.coords.isNotEmpty
            ? state.coords.first
            : context.bloc<DestinationCubit>().destination.midPointCoord;

        return Container(
          width: size.width * 0.9,
          height: size.height * 0.7,
          child: CustomMap(
            center: center,
            initialZoom: 17.0,
            children: [if (state.coords.isNotEmpty) const _MarkersLayer()],
            onTap: context.bloc<DestinationUpdatePostCubit>().updateCoords,
          ),
        );
      },
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  const _MarkersLayer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdatePostCubit, DestinationUpdatePostState>(
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
          onTap: () => context.bloc<DestinationUpdatePostCubit>().updateCoords(c),
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
