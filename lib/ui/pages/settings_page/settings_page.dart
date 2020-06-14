import 'package:flutter/material.dart';

import 'package:sahayatri/app/extensions/widget_x.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/pages/settings_page/widgets/contact_form.dart';
import 'package:sahayatri/ui/pages/settings_page/widgets/settings_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const Header(
              leftPadding: 0.0,
              boldTitle: 'Settings',
            ),
            const SizedBox(height: 16.0),
            SettingsCard(
              title: 'Close Contact',
              subtitle: 'Setup close contact to notify them about your whereabouts',
              icon: CommunityMaterialIcons.account_alert_outline,
              onTap: () => const ContactForm().openDialog(context),
            ),
            const SizedBox(height: 12.0),
            SettingsCard(
              title: 'Network',
              subtitle: 'Setup a network to remain connected with your friends',
              icon: CommunityMaterialIcons.access_point_network,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}