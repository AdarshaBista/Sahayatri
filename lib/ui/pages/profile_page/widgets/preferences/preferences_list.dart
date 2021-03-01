import 'package:flutter/material.dart';

import 'package:sahayatri/ui/pages/profile_page/widgets/preferences/theme_toggle.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/preferences/gps_accuracy_toggle.dart';
import 'package:sahayatri/ui/pages/profile_page/widgets/preferences/location_data_toggle.dart';

class PreferencesList extends StatelessWidget {
  const PreferencesList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          ThemeToggle(),
          SizedBox(height: 16.0),
          GpsAccuracyToggle(),
          SizedBox(height: 16.0),
          LocationDataToggle(),
        ],
      ),
    );
  }
}
