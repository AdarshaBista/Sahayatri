import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/nearby/nearby_form.dart';

class NearbyTab extends StatelessWidget {
  const NearbyTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: const [
          SizedBox(height: 8.0),
          NearbyForm(isOnSettings: false),
        ],
      ),
    );
  }
}
