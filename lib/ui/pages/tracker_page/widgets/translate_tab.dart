import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/translate/translate_form.dart';

class TranslateTab extends StatelessWidget {
  const TranslateTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Divider(height: 2.0, indent: 24.0, endIndent: 24.0),
        Expanded(child: TranslateForm(isOnSettings: false)),
      ],
    );
  }
}
