import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/map/custom_map.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class UpdateMapDialog extends StatelessWidget {
  final Coord coord;

  const UpdateMapDialog({
    @required this.coord,
  }) : assert(coord != null);

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.6, 0.0),
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

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.7,
      child: CustomMap(
        center: coord,
        minZoom: 18.0,
        initialZoom: 18.5,
        children: [_MarkerLayer(coord: coord)],
        swPanBoundary: Coord(lat: coord.lat - 0.005, lng: coord.lng - 0.005),
        nePanBoundary: Coord(lat: coord.lat + 0.005, lng: coord.lng + 0.005),
      ),
    );
  }
}

class _MarkerLayer extends StatelessWidget {
  final Coord coord;

  const _MarkerLayer({
    @required this.coord,
  }) : assert(coord != null);

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: [
          Marker(
            width: 32.0,
            height: 32.0,
            point: coord.toLatLng(),
            anchorPos: AnchorPos.align(AnchorAlign.top),
            builder: (context) {
              return const Icon(
                CommunityMaterialIcons.map_marker,
                size: 32.0,
                color: AppColors.secondary,
              );
            },
          ),
        ],
      ),
    );
  }
}
