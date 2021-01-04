import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class TextMarker extends Marker {
  TextMarker({
    @required final String text,
    @required final Color color,
    @required final Coord coord,
    final Function(BuildContext) onTap,
    final bool hideText = false,
    final IconData icon = CommunityMaterialIcons.map_marker,
  })  : assert(text != null),
        assert(icon != null),
        assert(color != null),
        assert(coord != null),
        assert(hideText != null),
        super(
          width: 100.0,
          height: 100.0,
          point: coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (context) => GestureDetector(
            onTap: () => onTap(context),
            child: ScaleAnimator(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!hideText)
                    Flexible(
                      child: FadeAnimator(
                        child: BlocBuilder<PrefsCubit, PrefsState>(
                          builder: (context, state) {
                            return Text(
                              text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.headline6.bold.light.copyWith(
                                color: _getColor(state.prefs.mapStyle),
                                shadows: _getTextShadows(state.prefs.mapStyle),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 2.0),
                  Icon(
                    icon,
                    size: 28.0,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        );

  static List<Shadow> _getTextShadows(String mapStyle) {
    return [
      Shadow(
        blurRadius: 2.0,
        color: _getShadowColor(mapStyle),
        offset: const Offset(2.0, 2.0),
      ),
    ];
  }

  static Color _getColor(String mapStyle) {
    switch (mapStyle) {
      case MapStyles.dark:
      case MapStyles.satellite:
        return AppColors.light;
      case MapStyles.light:
      case MapStyles.streets:
      case MapStyles.outdoors:
        return AppColors.dark;
      default:
        return AppColors.light;
    }
  }

  static Color _getShadowColor(String mapStyle) {
    switch (mapStyle) {
      case MapStyles.dark:
      case MapStyles.satellite:
        return AppColors.dark;
      case MapStyles.light:
      case MapStyles.streets:
      case MapStyles.outdoors:
        return AppColors.light;
      default:
        return AppColors.dark;
    }
  }
}
