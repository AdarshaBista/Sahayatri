import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/core/models/nearby_device.dart';
import 'package:sahayatri/ui/pages/tracker_page/widgets/map/device_details.dart';

class DeviceMarker extends Marker {
  DeviceMarker(
    BuildContext context, {
    @required NearbyDevice device,
  })  : assert(device != null),
        super(
          width: 24.0,
          height: 24.0,
          point: device.userLocation.coord.toLatLng(),
          builder: (_) => GestureDetector(
            onTap: () => DeviceDetails(deviceId: device.id).openModalBottomSheet(context),
            child: const Icon(
              Icons.radio_button_checked,
              size: 24.0,
              color: Colors.blue,
            ),
          ),
        );
}
