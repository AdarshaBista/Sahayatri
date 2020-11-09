import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/nearby/device_tile.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class DevicesList extends StatelessWidget {
  const DevicesList();

  @override
  Widget build(BuildContext context) {
    final connectedDevices = context
        .select<NearbyConnected, List<NearbyDevice>>((state) => state.connectedDevices);

    return connectedDevices.isEmpty
        ? Text(
            'No devices found yet.',
            style: AppTextStyles.extraSmall.secondary,
          )
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: connectedDevices.length,
            itemBuilder: (context, index) {
              return SlideAnimator(
                begin: Offset(0.0, 0.2 + index * 0.4),
                child: DeviceTile(
                  index: index,
                  device: connectedDevices[index],
                ),
              );
            },
          );
  }
}
