import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:sahayatri/core/models/map_layer.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class LayersButton extends StatelessWidget {
  const LayersButton();

  static const List<MapLayer> kLayers = [
    MapLayer(
      title: 'Dark',
      value: Values.kMapStyleDark,
      icon: CommunityMaterialIcons.weather_night,
    ),
    MapLayer(
      title: 'Light',
      value: Values.kMapStyleLight,
      icon: CommunityMaterialIcons.weather_sunny,
    ),
    MapLayer(
      title: 'Streets',
      value: Values.kMapStyleStreets,
      icon: CommunityMaterialIcons.google_street_view,
    ),
    MapLayer(
      title: 'Outdoors',
      value: Values.kMapStyleOutdoors,
      icon: CommunityMaterialIcons.hiking,
    ),
    MapLayer(
      title: 'Satellite',
      value: Values.kMapStyleSatellite,
      icon: CommunityMaterialIcons.earth,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            initialValue: kLayers[3],
            color: AppColors.background,
            onSelected: (layer) {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                CommunityMaterialIcons.layers,
                color: AppColors.primary,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return kLayers
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
}
