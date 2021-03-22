import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/nearby/devices_list.dart';
import 'package:sahayatri/ui/widgets/nearby/nearby_actions.dart';
import 'package:sahayatri/ui/widgets/indicators/scan_indicator.dart';

class ConnectionInfo extends StatelessWidget {
  const ConnectionInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildName(),
        const SizedBox(height: 10.0),
        _buildScanIndicator(),
        const SizedBox(height: 10.0),
        const NearbyActions(),
        const SizedBox(height: 20.0),
        Text(
          'CONNECTED DEVIECS',
          style: context.t.headline5.bold,
        ),
        const SizedBox(height: 8.0),
        const DevicesList(),
      ],
    );
  }

  Widget _buildName() {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        return Text(
          'Your Name : ${state.prefs.deviceName}',
          style: context.t.headline5.bold,
        );
      },
    );
  }

  Widget _buildScanIndicator() {
    return BlocBuilder<NearbyCubit, NearbyState>(
      builder: (context, state) {
        return (state as NearbyConnected).isScanning
            ? const ScanIndicator()
            : const SizedBox();
      },
    );
  }
}
