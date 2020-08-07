import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class DeviceStatusRow extends StatelessWidget {
  final DeviceStatus status;

  const DeviceStatusRow({
    @required this.status,
  }) : assert(status != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: 2.0),
        Text(
          _getStatusText(),
          style: AppTextStyles.extraSmall,
        ),
      ],
    );
  }

  Widget _buildIcon() {
    if (status == DeviceStatus.connected) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 12.0,
      );
    } else if (status == DeviceStatus.connecting) {
      return const Icon(
        Icons.radio_button_checked,
        color: Colors.blue,
        size: 12.0,
      );
    } else {
      return const Icon(
        Icons.remove_circle,
        color: Colors.red,
        size: 12.0,
      );
    }
  }

  String _getStatusText() {
    if (status == DeviceStatus.connected) {
      return 'Connected';
    } else if (status == DeviceStatus.connecting) {
      return 'Connecting...';
    } else {
      return 'Disconnected';
    }
  }
}
