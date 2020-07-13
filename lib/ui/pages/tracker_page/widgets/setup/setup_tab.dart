import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:sahayatri/ui/shared/widgets/form/contact_form.dart';

class SetupTab extends StatelessWidget {
  final ScrollController controller;

  const SetupTab({
    @required this.controller,
  }) : assert(controller != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const ContactForm(shouldPop: false),
        const Divider(height: 16.0),
        Container(),
      ],
    );
  }
}
