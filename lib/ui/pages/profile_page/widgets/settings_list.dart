import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/tools/tools_card.dart';
import 'package:sahayatri/ui/widgets/common/theme_sheet.dart';

class SettingsList extends StatelessWidget {
  const SettingsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToolsCard(
            title: 'Change Theme',
            subtitle: 'Toggle between light, dark or system theme.',
            icon: CommunityMaterialIcons.theme_light_dark,
            onTap: () => ThemeSheet(
              onSelect: (value) {
                context.read<ThemeCubit>().changeTheme(value);
                context.read<PrefsCubit>().saveTheme(context.read<ThemeCubit>().themeStr);
              },
            ).openModalBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
