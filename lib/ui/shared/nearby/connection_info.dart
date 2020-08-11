import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/nearby/devices_list.dart';
import 'package:sahayatri/ui/shared/nearby/nearby_actions.dart';
import 'package:sahayatri/ui/shared/indicators/scan_indicator.dart';

class ConnectionInfo extends StatelessWidget {
  const ConnectionInfo();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NearbyConnected>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Name : ${context.bloc<NearbyCubit>().username}',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 10.0),
        if (state.isScanning) _buildScanIndicator(),
        const SizedBox(height: 10.0),
        const NearbyActions(),
        const SizedBox(height: 20.0),
        Text(
          'CONNECTED DEVIECS',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        const DevicesList(),
      ],
    );
  }

  Widget _buildScanIndicator() {
    return BlocBuilder<NearbyCubit, NearbyState>(
      builder: (context, state) {
        return (state as NearbyConnected).isScanning
            ? const ScanIndicator()
            : const Offstage();
      },
    );
  }
}
