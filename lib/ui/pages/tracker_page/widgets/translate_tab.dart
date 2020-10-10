import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/translate/translate_form.dart';

class TranslateTab extends StatelessWidget {
  const TranslateTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: const [
          Divider(height: 2.0),
          SizedBox(height: 12.0),
          TranslateForm(isOnSettings: false),
        ],
      ),
    );
  }
}
