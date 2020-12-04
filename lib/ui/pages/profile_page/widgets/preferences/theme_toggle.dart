import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/common/toggle_grid.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle();

  @override
  Widget build(BuildContext context) {
    return ToggleGrid<ThemeMode>(
      title: 'Theme',
      initialValue: BlocProvider.of<ThemeCubit>(context).state,
      onSelected: (mode) => onSelected(context, mode),
      items: [
        ToggleItem(
          label: 'System',
          value: ThemeMode.system,
          icon: CommunityMaterialIcons.theme_light_dark,
        ),
        ToggleItem(
          label: 'Light',
          value: ThemeMode.light,
          icon: CommunityMaterialIcons.weather_sunny,
        ),
        ToggleItem(
          label: 'Dark',
          value: ThemeMode.dark,
          icon: CommunityMaterialIcons.weather_night,
        ),
      ],
    );
  }

  void onSelected(BuildContext context, ThemeMode mode) {
    context.read<ThemeCubit>().changeTheme(mode);
    context.read<PrefsCubit>().saveTheme(context.read<ThemeCubit>().themeStr);
  }
}
