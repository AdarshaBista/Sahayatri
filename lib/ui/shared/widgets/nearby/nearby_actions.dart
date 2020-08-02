import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_button.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/custom_button.dart';

class NearbyActions extends StatelessWidget {
  const NearbyActions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyBloc, NearbyState>(
      builder: (context, state) {
        if (state is NearbyInProgress) {
          return _buildNearbyProgress(context, state.isScanning);
        } else {
          return _buildNearbyInitial(context);
        }
      },
    );
  }

  Widget _buildNearbyProgress(BuildContext context, bool isScanning) {
    return Row(
      children: [
        NearbyButton(
          label: isScanning ? 'Stop\nScanning' : 'Start\nScanning',
          color: isScanning ? Colors.orange : Colors.green,
          icon: isScanning
              ? Icons.search_off_outlined
              : CommunityMaterialIcons.account_search_outline,
          onTap: () {
            isScanning
                ? context.bloc<NearbyBloc>().add(const ScanningStopped())
                : context.bloc<NearbyBloc>().add(const ScanningStarted());
          },
        ),
        const SizedBox(width: 12.0),
        NearbyButton(
          label: 'Stop\n Nearby',
          color: Colors.red,
          icon: Icons.exit_to_app_outlined,
          onTap: () => context.bloc<NearbyBloc>().add(const NearbyStopped()),
        ),
      ],
    );
  }

  Widget _buildNearbyInitial(BuildContext context) {
    return CustomButton(
      label: 'Start Nearby',
      iconData: CommunityMaterialIcons.circle_double,
      onTap: () => context.bloc<NearbyBloc>().add(const NearbyStarted()),
    );
  }
}
