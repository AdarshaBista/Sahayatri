import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/tracker/tracker_service.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/toggle_grid.dart';

class LocationDataToggle extends StatelessWidget {
  const LocationDataToggle();

  @override
  Widget build(BuildContext context) {
    return ToggleGrid<bool>(
      title: 'Location Data',
      initialValue: true,
      onSelected: (isMock) => onSelected(context, isMock),
      items: [
        ToggleItem(
          label: 'GPS',
          value: false,
          icon: AppIcons.gpsLocation,
        ),
        ToggleItem(
          label: 'Mock',
          value: true,
          icon: AppIcons.mockLocation,
        ),
      ],
    );
  }

  void onSelected(BuildContext context, bool isMock) {
    final trackerService = locator<TrackerService>();
    if (isMock) {
      trackerService.locationService = locator(instanceName: 'mock');
    } else {
      trackerService.locationService = locator();
    }
  }
}
