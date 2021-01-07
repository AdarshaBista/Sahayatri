import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/square_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class NearbyActions extends StatelessWidget {
  const NearbyActions();

  @override
  Widget build(BuildContext context) {
    final isScanning = context.watch<NearbyConnected>().isScanning;

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        SquareButton(
          label: isScanning ? 'Stop\nScanning' : 'Start\nScanning',
          backgroundColor: isScanning
              ? Colors.deepPurple.withOpacity(0.3)
              : Colors.green.withOpacity(0.3),
          icon: isScanning
              ? Icons.search_off_outlined
              : CommunityMaterialIcons.account_search_outline,
          onTap: () {
            isScanning
                ? context.read<NearbyCubit>().stopScanning()
                : context.read<NearbyCubit>().startScanning();
          },
        ),
        SquareButton(
          label: 'Stop\n Nearby',
          backgroundColor: AppColors.secondaryLight,
          icon: CommunityMaterialIcons.access_point_network_off,
          onTap: () => ConfirmDialog(
            message: 'Are you sure you want to stop nearby.',
            onConfirm: () => context.read<NearbyCubit>().stopNearby(),
          ).openDialog(context),
        ),
        SquareButton(
          label: 'Send\n SOS',
          backgroundColor: AppColors.primaryLight,
          icon: Icons.speaker_phone_outlined,
          onTap: () {
            context.openFlushBar('SOS Sent', type: FlushbarType.success);
            context.read<NearbyCubit>().sendSos();
          },
        ),
      ],
    );
  }
}
