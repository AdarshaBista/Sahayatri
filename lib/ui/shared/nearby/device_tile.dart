import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/nearby/device_status_row.dart';

class DeviceTile extends StatelessWidget {
  final int index;
  final NearbyDevice device;

  const DeviceTile({
    @required this.index,
    @required this.device,
  })  : assert(index != null),
        assert(device != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        device.name,
        style: AppTextStyles.medium,
      ),
      subtitle: DeviceStatusRow(status: device.status),
      leading: CircleAvatar(
        radius: 16.0,
        backgroundColor: AppColors.primaryLight,
        child: Text(
          '${index + 1}',
          style: AppTextStyles.small.bold,
        ),
      ),
    );
  }
}
