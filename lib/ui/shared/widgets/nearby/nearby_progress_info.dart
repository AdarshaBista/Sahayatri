import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/indicators/scan_indicator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_actions.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/connected_list.dart';

class NearbyProgressInfo extends StatelessWidget {
  const NearbyProgressInfo();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NearbyInProgress>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your username : ${context.bloc<NearbyBloc>().username}',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 12.0),
        const NearbyActions(),
        const SizedBox(height: 16.0),
        if (state.isScanning) _buildScanIndicator(),
        const SizedBox(height: 16.0),
        Text(
          'CONNECTED DEVIECS',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        const ConnectedList(),
      ],
    );
  }

  Widget _buildScanIndicator() {
    return BlocBuilder<NearbyBloc, NearbyState>(
      builder: (context, state) {
        return (state as NearbyInProgress).isScanning
            ? const ScanIndicator()
            : const Offstage();
      },
    );
  }
}
