import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/stat_tile.dart';
import 'package:sahayatri/ui/widgets/nearby/device_status_row.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class DeviceDetails extends StatelessWidget {
  final String deviceId;

  const DeviceDetails({
    @required this.deviceId,
  }) : assert(deviceId != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyCubit, NearbyState>(
      builder: (context, state) {
        final deviceReactive = (state as NearbyConnected)
            .trackingDevices
            .firstWhere((d) => d.id == deviceId, orElse: () => null);

        if (deviceReactive == null) return const SizedBox();

        return SlideAnimator(
          begin: const Offset(0.0, 0.5),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
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
        const SizedBox(height: 6.0),
        DeviceStatusRow(status: device.status),
        const SizedBox(height: 16.0),
        StatTile(
          label: 'Altitude',
          icon: AppIcons.altitude,
          stat: '${device.userLocation.altitude.floor()} m',
        ),
        StatTile(
          label: 'Speed',
          icon: AppIcons.speed,
          stat: '${device.userLocation.speed.toStringAsFixed(1)} m/s',
        ),
        StatTile(
          label: 'Accuracy',
          icon: AppIcons.accuracy,
          stat: '${device.userLocation.accuracy.toStringAsFixed(1)} m',
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, NearbyDevice device) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            device.name.toUpperCase(),
            maxLines: 2,
            style: context.t.headline2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 16.0),
        if (device.status == DeviceStatus.disconnected)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              context.read<NearbyCubit>().removeDevice(device);
            },
            child: ScaleAnimator(
              child: Text(
                'REMOVE',
                style: AppTextStyles.headline5.secondary,
              ),
            ),
          ),
      ],
    );
  }
}
