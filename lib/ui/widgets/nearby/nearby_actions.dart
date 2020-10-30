import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/widgets/nearby/nearby_button.dart';
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
        NearbyButton(
          label: isScanning ? 'Stop\nScanning' : 'Start\nScanning',
          color: isScanning ? Colors.blue : Colors.green,
          icon: isScanning
              ? Icons.search_off_outlined
              : CommunityMaterialIcons.account_search_outline,
          onTap: () {
            isScanning
                ? context.bloc<NearbyCubit>().stopScanning()
                : context.bloc<NearbyCubit>().startScanning();
          },
        ),
        NearbyButton(
          label: 'Stop\n Nearby',
          color: Colors.orange,
          icon: Icons.exit_to_app_outlined,
          onTap: () => ConfirmDialog(
            message: 'Are you sure you want to stop nearby.',
            onConfirm: () => context.bloc<NearbyCubit>().stopNearby(),
          ).openDialog(context),
        ),
        NearbyButton(
          label: 'Send\n SOS',
          color: Colors.red,
          icon: Icons.speaker_phone_outlined,
          onTap: () {
            context.openFlushBar('SOS Sent', type: FlushbarType.success);
            context.bloc<NearbyCubit>().sendSos();
          },
        ),
      ],
    );
  }
}
