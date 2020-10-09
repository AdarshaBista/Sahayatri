import 'package:flutter/material.dart';

import 'package:sahayatri/ui/shared/nearby/nearby_form.dart';

class NearbyTab extends StatelessWidget {
  const NearbyTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: const [
          Divider(height: 2.0),
          SizedBox(height: 12.0),
          NearbyForm(isOnSettings: false),
        ],
      ),
    );
  }
}
