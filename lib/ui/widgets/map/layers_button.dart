import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class LayersButton extends StatelessWidget {
  const LayersButton();

  List<_MapLayerData> get _mapLayersData => [
        const _MapLayerData(
          title: 'Dark',
          style: MapStyles.kDark,
          icon: CommunityMaterialIcons.weather_night,
        ),
        const _MapLayerData(
          title: 'Light',
          style: MapStyles.kLight,
          icon: CommunityMaterialIcons.weather_sunny,
        ),
        const _MapLayerData(
          title: 'Streets',
          style: MapStyles.kStreets,
          icon: CommunityMaterialIcons.google_street_view,
        ),
        const _MapLayerData(
          title: 'Satellite',
          style: MapStyles.kSatellite,
          icon: CommunityMaterialIcons.earth,
        ),
        const _MapLayerData(
          title: 'Outdoors',
          style: MapStyles.kOutdoors,
          icon: CommunityMaterialIcons.hiking,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: SlideAnimator(
            begin: const Offset(1.0, 0.0),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.dark,
                shape: BoxShape.circle,
              ),
              child: PopupMenuButton<String>(
                elevation: 6.0,
                initialValue: (state as PrefsLoaded).prefs.mapStyle,
                color: AppColors.light,
                onSelected: (mapStyle) =>
                    context.bloc<PrefsCubit>().changeMapLayer(mapStyle),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CommunityMaterialIcons.layers_outline,
                    color: AppColors.primary,
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return _mapLayersData
                      .map((layer) => PopupMenuItem<String>(
                            value: layer.style,
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

  Widget _buildTile(_MapLayerData layer) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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

class _MapLayerData {
  final String title;
  final String style;
  final IconData icon;

  const _MapLayerData({
    @required this.title,
    @required this.style,
    @required this.icon,
  })  : assert(title != null),
        assert(style != null),
        assert(icon != null);
}
