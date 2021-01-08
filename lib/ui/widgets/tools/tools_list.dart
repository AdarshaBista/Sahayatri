import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/tools/tools_card.dart';
import 'package:sahayatri/ui/widgets/nearby/nearby_form.dart';
import 'package:sahayatri/ui/widgets/contact/contact_form.dart';
import 'package:sahayatri/ui/widgets/translate/translate_form.dart';

class ToolsList extends StatelessWidget {
  const ToolsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToolsCard(
            title: 'Nearby Network',
            subtitle: 'Setup a network to remain connected with your friends nearby.',
            icon: AppIcons.nearby,
            onTap: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: NearbyForm(),
            ).openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          ToolsCard(
            title: 'Translate',
            subtitle: 'Translate from one language to another with text to speech.',
            icon: AppIcons.translate,
            onTap: () => const TranslateForm().openModalBottomSheet(context),
          ),
          const SizedBox(height: 12.0),
          ToolsCard(
            title: 'Close Contact',
            subtitle: 'Setup close contact to notify them about your whereabouts.',
            icon: AppIcons.contact,
            onTap: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: ContactForm(isOnSettings: true),
            ).openModalBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
