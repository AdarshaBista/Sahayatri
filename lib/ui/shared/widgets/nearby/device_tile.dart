import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';

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
      subtitle: Row(
        children: [
          Icon(
            device.isConnecting ? Icons.radio_button_checked : Icons.check_circle,
            color: device.isConnecting ? Colors.blue : Colors.green,
            size: 12.0,
          ),
          const SizedBox(width: 2.0),
          Text(
            device.isConnecting ? 'Connecting...' : 'Connected',
            style: AppTextStyles.extraSmall,
          ),
        ],
      ),
      leading: CircleAvatar(
        radius: 16.0,
        backgroundColor: AppColors.primary.withOpacity(0.4),
        child: Text(
          '${index + 1}',
          style: AppTextStyles.small.bold,
        ),
      ),
    );
  }
}
