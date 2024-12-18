import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/dialog_extension.dart';
import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/pages/tracker_page/widgets/map/device_details.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/dynamic_text_marker.dart';

class DeviceMarker extends DynamicTextMarker {
  DeviceMarker({
    required super.shrinkWhen,
    required NearbyDevice device,
  }) : super(
          label: device.name,
          color: Colors.blue,
          coord: device.userLocation!.coord,
          icon: AppIcons.nearbyDevice,
          onTap: DeviceDetails(deviceId: device.id).openModalBottomSheet,
        );
}
