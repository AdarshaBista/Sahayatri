import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/form/contact_form.dart';
import 'package:sahayatri/ui/shared/nearby/nearby_form.dart';
import 'package:sahayatri/ui/shared/widgets/elevated_card.dart';

class SetupTab extends StatelessWidget {
  const SetupTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: const [
        ElevatedCard(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ContactForm(isOnSettings: false),
        ),
        ElevatedCard(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: NearbyForm(isOnSettings: false),
        ),
      ],
    );
  }
}
