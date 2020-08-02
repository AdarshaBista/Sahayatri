import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:community_material_icon/community_material_icon.dart';

class DeviceDetails extends StatelessWidget {
  final NearbyDevice device;

  const DeviceDetails({
    @required this.device,
  }) : assert(device != null);

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.name.toUpperCase(),
              style: AppTextStyles.large.bold,
            ),
            const SizedBox(height: 16.0),
            _buildStat(
              label: 'Altitude',
              icon: CommunityMaterialIcons.altimeter,
              value: '${device.userLocation.altitude.floor()} m',
            ),
            _buildStat(
              label: 'Speed',
              icon: CommunityMaterialIcons.speedometer,
              value: '${device.userLocation.speed.toStringAsFixed(1)} m/s',
            ),
            _buildStat(
              label: 'Accuracy',
              icon: CommunityMaterialIcons.circle_slice_8,
              value: '${device.userLocation.accuracy.toStringAsFixed(1)} m',
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({String label, IconData icon, String value}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: AppTextStyles.small,
      ),
      leading: Icon(
        icon,
        size: 24.0,
      ),
      trailing: Text(
        value,
        style: AppTextStyles.medium.bold,
      ),
    );
  }
}
