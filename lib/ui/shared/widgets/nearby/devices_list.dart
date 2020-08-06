import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/device_tile.dart';

class DevicesList extends StatelessWidget {
  const DevicesList();

  @override
  Widget build(BuildContext context) {
    final nearbyDevices = context.watch<NearbyConnected>().nearbyDevices;

    return nearbyDevices.isEmpty
        ? Text(
            'No devices found yet.',
            style: AppTextStyles.small.secondary,
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nearbyDevices.length,
            itemBuilder: (context, index) {
              return SlideAnimator(
                begin: Offset(0.0, 0.2 + index * 0.4),
                child: DeviceTile(
                  index: index,
                  device: nearbyDevices[index],
                ),
              );
            },
          );
  }
}