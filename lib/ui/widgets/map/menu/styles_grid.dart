import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/toggle_grid.dart';

class StylesGrid extends StatelessWidget {
  const StylesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleGrid<String>(
      title: 'Map Style',
      titlePadding: 0.0,
      iconColor: AppColors.light,
      backgroundColor: AppColors.darkFaded,
      titleStyle: AppTextStyles.headline3.thin.light,
      initialValue: BlocProvider.of<PrefsCubit>(context).prefs.mapStyle,
      onSelected: (style) => context.read<PrefsCubit>().saveMapStyle(style),
      items: [
        ToggleItem(
          label: 'Dark',
          value: MapStyles.dark,
          icon: AppIcons.night,
        ),
        ToggleItem(
          label: 'Light',
          value: MapStyles.light,
          icon: AppIcons.day,
        ),
        ToggleItem(
          label: 'Streets',
          value: MapStyles.streets,
          icon: AppIcons.street,
        ),
        ToggleItem(
          label: 'Satellite',
          value: MapStyles.satellite,
          icon: AppIcons.satellite,
        ),
        ToggleItem(
          label: 'Outdoors',
          value: MapStyles.outdoors,
          icon: AppIcons.outdoors,
        ),
      ],
    );
  }
}
