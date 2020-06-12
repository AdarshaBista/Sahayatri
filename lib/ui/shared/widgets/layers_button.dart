import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/map_layers.dart';

import 'package:sahayatri/core/models/map_layer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class LayersButton extends StatelessWidget {
  const LayersButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: ScaleAnimator(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.dark,
                shape: BoxShape.circle,
              ),
              child: PopupMenuButton<MapLayer>(
                elevation: 6.0,
                initialValue: state.prefs.mapLayer,
                color: AppColors.background,
                onSelected: (mapLayer) {
                  _showSnackBar(context);
                  context.bloc<PrefsBloc>().add(MapLayerChanged(mapLayer: mapLayer));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CommunityMaterialIcons.layers,
                    color: AppColors.primary,
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return kMapLayers.values
                      .map((layer) => PopupMenuItem(
                            value: layer,
                            child: _buildTile(layer),
                          ))
                      .toList();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile(MapLayer layer) {
    return ListTile(
      title: Text(
        layer.title,
        style: AppTextStyles.small.bold,
      ),
      leading: Icon(
        layer.icon,
        size: 22.0,
        color: AppColors.dark,
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'You may need to reload the map to see changes.',
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
