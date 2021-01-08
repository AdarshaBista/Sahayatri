import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';

class DeviceStatusRow extends StatelessWidget {
  final DeviceStatus status;

  const DeviceStatusRow({
    @required this.status,
  }) : assert(status != null);

  @override
  Widget build(BuildContext context) {
    return IconLabel(
      gap: 2.0,
      icon: _getIcon(),
      label: _getStatusText(),
      iconColor: _getIconColor(),
      labelStyle: context.t.headline6,
    );
  }

  IconData _getIcon() {
    if (status == DeviceStatus.connected) {
      return AppIcons.deviceConnected;
    } else if (status == DeviceStatus.connecting) {
      return AppIcons.deviceConnecting;
    } else {
      return AppIcons.deviceDisconnected;
    }
  }

  Color _getIconColor() {
    if (status == DeviceStatus.connected) {
      return Colors.green;
    } else if (status == DeviceStatus.connecting) {
      return Colors.blue;
    } else {
      return Colors.red;
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
