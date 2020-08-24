import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/contact_form.dart';
import 'package:sahayatri/ui/shared/nearby/nearby_form.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/settings/settings_card.dart';

class SettingsList extends StatelessWidget {
  const SettingsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Settings',
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 16.0),
          SettingsCard(
            title: 'Close Contact',
            subtitle: 'Setup close contact to notify them about your whereabouts.',
            icon: CommunityMaterialIcons.account_alert_outline,
            onTap: () => const Padding(
              padding: EdgeInsets.all(24.0),
              child: ContactForm(isOnSettings: true),
            ).openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          SettingsCard(
            title: 'Nearby Network',
            subtitle: 'Setup a network to remain connected with your friends nearby.',
            icon: CommunityMaterialIcons.access_point_network,
            onTap: () => const Padding(
              padding: EdgeInsets.all(24.0),
              child: NearbyForm(isOnSettings: true),
            ).openModalBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
