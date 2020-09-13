import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/map/custom_map.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class UpdateMapDialog extends StatelessWidget {
  final List<Coord> coords;

  const UpdateMapDialog({
    @required this.coords,
  }) : assert(coords != null);

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
        minZoom: 18.0,
        initialZoom: 18.5,
        center: coords.first,
        children: [_MarkersLayer(coords: coords)],
      ),
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  final List<Coord> coords;

  const _MarkersLayer({
    @required this.coords,
  }) : assert(coords != null);

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: coords
            .map((c) => Marker(
                  width: 32.0,
                  height: 32.0,
                  point: c.toLatLng(),
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  builder: (context) {
                    return const Icon(
                      CommunityMaterialIcons.map_marker,
                      size: 32.0,
                      color: AppColors.secondary,
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
