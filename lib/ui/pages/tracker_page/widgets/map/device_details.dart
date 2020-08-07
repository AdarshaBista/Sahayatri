import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/device_status_row.dart';

class DeviceDetails extends StatelessWidget {
  final String deviceId;

  const DeviceDetails({
    @required this.deviceId,
  }) : assert(deviceId != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        final deviceReactive = (state as NearbyConnected)
            .trackingDevices
            .firstWhere((d) => d.id == deviceId, orElse: () => null);

        if (deviceReactive == null) return const Offstage();

        return SlideAnimator(
          begin: const Offset(0.0, 0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
            child: _buildBottomSheet(context, deviceReactive),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, NearbyDevice device) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, device),
        const SizedBox(height: 8.0),
        DeviceStatusRow(status: device.status),
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
    );
  }

  Widget _buildTitle(BuildContext context, NearbyDevice device) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          device.name.toUpperCase(),
          style: AppTextStyles.large.bold,
        ),
        const SizedBox(width: 16.0),
        if (device.status == DeviceStatus.disconnected)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              context.bloc<NearbyCubit>().removeDevice(device);
            },
            child: ScaleAnimator(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: AppColors.dark,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
      ],
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
