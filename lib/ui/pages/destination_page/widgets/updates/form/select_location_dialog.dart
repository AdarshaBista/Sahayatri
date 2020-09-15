import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/map/custom_map.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class SelectLocationDialog extends StatefulWidget {
  final List<Coord> coords;
  final Function(Coord) onAdd;
  final Function(Coord) onRemove;

  const SelectLocationDialog({
    @required this.coords,
    @required this.onAdd,
    @required this.onRemove,
  })  : assert(coords != null),
        assert(onAdd != null),
        assert(onRemove != null);

  @override
  _SelectLocationDialogState createState() => _SelectLocationDialogState();
}

class _SelectLocationDialogState extends State<SelectLocationDialog> {
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
    final center = widget.coords.isNotEmpty
        ? widget.coords.first
        : context.bloc<DestinationCubit>().destination.midPointCoord;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.7,
      child: CustomMap(
        center: center,
        initialZoom: 17.0,
        onTap: (coord) => setState(() => widget.onAdd(coord)),
        children: [
          if (widget.coords.isNotEmpty)
            _MarkersLayer(
              coords: widget.coords,
              onRemove: (coord) => setState(() => widget.onRemove(coord)),
            ),
        ],
      ),
    );
  }
}

class _MarkersLayer extends StatelessWidget {
  final List<Coord> coords;
  final Function(Coord) onRemove;

  const _MarkersLayer({
    @required this.coords,
    @required this.onRemove,
  })  : assert(coords != null),
        assert(onRemove != null);

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
          onTap: () => onRemove(c),
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
