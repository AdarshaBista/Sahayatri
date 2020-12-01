import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/common/theme_sheet.dart';
import 'package:sahayatri/ui/widgets/nearby/nearby_form.dart';
import 'package:sahayatri/ui/widgets/contact/contact_form.dart';
import 'package:sahayatri/ui/widgets/settings/settings_card.dart';
import 'package:sahayatri/ui/widgets/translate/translate_form.dart';

class SettingsList extends StatelessWidget {
  const SettingsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsCard(
            title: 'Nearby Network',
            subtitle: 'Setup a network to remain connected with your friends nearby.',
            icon: CommunityMaterialIcons.access_point_network,
            onTap: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: NearbyForm(isOnSettings: true),
            ).openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          SettingsCard(
            title: 'Translate',
            subtitle: 'Translate from one language to another with text to speech.',
            icon: CommunityMaterialIcons.translate,
            onTap: () => const TranslateForm(
              isOnSettings: true,
            ).openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          SettingsCard(
            title: 'Close Contact',
            subtitle: 'Setup close contact to notify them about your whereabouts.',
            icon: CommunityMaterialIcons.account_alert_outline,
            onTap: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: ContactForm(isOnSettings: true),
            ).openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          SettingsCard(
            title: 'Change Theme',
            subtitle: 'Toggle between light and dark theme.',
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
