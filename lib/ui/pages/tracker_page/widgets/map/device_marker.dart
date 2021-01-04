import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/core/models/nearby_device.dart';
import 'package:sahayatri/ui/widgets/map/text_marker.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/device_details.dart';

class DeviceMarker extends TextMarker {
  DeviceMarker({
    @required bool hideText,
    @required NearbyDevice device,
  })  : assert(device != null),
        super(
          hideText: hideText,
          text: device.name,
          color: Colors.blue,
          coord: device.userLocation.coord,
          icon: Icons.radio_button_checked,
          onTap: (context) =>
              DeviceDetails(deviceId: device.id).openModalBottomSheet(context),
        );
}
