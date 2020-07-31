import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/widgets/form/contact_form.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_form.dart';

class SetupTab extends StatelessWidget {
  const SetupTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: const [
        ContactForm(shouldPop: false),
        Divider(height: 16.0),
        NearbyForm(),
      ],
    );
  }
}
