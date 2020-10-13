import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/nearby/nearby_form.dart';

class NearbyTab extends StatelessWidget {
  const NearbyTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: const [
          SizedBox(height: 12.0),
          NearbyForm(isOnSettings: false),
        ],
      ),
    );
  }
}
