import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/toggle_grid.dart';

class StylesGrid extends StatelessWidget {
  const StylesGrid();

  @override
  Widget build(BuildContext context) {
    return ToggleGrid<String>(
      title: 'Map Style',
      iconColor: AppColors.light,
      backgroundColor: AppColors.darkAccent,
      titleStyle: AppTextStyles.headline5.bold.light,
      initialValue: BlocProvider.of<PrefsCubit>(context).prefs.mapStyle,
      onSelected: (style) => context.read<PrefsCubit>().saveMapLayer(style),
      items: [
        ToggleItem(
          label: 'Dark',
          value: MapStyles.dark,
          icon: CommunityMaterialIcons.weather_night,
        ),
        ToggleItem(
          label: 'Light',
          value: MapStyles.light,
          icon: CommunityMaterialIcons.weather_sunny,
        ),
        ToggleItem(
          label: 'Streets',
          value: MapStyles.streets,
          icon: CommunityMaterialIcons.google_street_view,
        ),
        ToggleItem(
          label: 'Satellite',
          value: MapStyles.satellite,
          icon: CommunityMaterialIcons.earth,
        ),
        ToggleItem(
          label: 'Outdoors',
          value: MapStyles.outdoors,
          icon: CommunityMaterialIcons.hiking,
        ),
      ],
    );
  }
}
