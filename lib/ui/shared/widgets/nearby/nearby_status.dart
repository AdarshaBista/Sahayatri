import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/connected_list.dart';

class NearbyStatus extends StatelessWidget {
  final List<String> connected;

  const NearbyStatus({
    @required this.connected,
  }) : assert(connected != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildScanAction(context),
        _buildScanIndicator(),
        const SizedBox(height: 16.0),
        Text(
          'CONNECTED DEVIECS',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        connected.isEmpty
            ? Text(
                'No devices found yet.',
                style: AppTextStyles.small.secondary,
              )
            : ConnectedList(connected: connected),
      ],
    );
  }

  Widget _buildScanIndicator() {
    return Container(
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(16.0),
      child: LoadingIndicator(
        color: AppColors.primary,
        indicatorType: Indicator.ballScaleMultiple,
      ),
    );
  }

  Widget _buildScanAction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Searching...',
          style: AppTextStyles.small,
        ),
        const SizedBox(width: 12.0),
        GestureDetector(
          onTap: () => context.bloc<NearbyBloc>().add(const NearbyStopped()),
          child: Text(
            'Stop',
            style: AppTextStyles.small.bold.secondary,
          ),
        ),
      ],
    );
  }
}
