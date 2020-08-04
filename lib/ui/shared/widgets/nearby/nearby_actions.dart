import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_button.dart';
import 'package:sahayatri/ui/shared/widgets/dialogs/confirm_dialog.dart';

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
                ? context.bloc<NearbyBloc>().add(const ScanningStopped())
                : context.bloc<NearbyBloc>().add(const ScanningStarted());
          },
        ),
        NearbyButton(
          label: 'Stop\n Nearby',
          color: Colors.orange,
          icon: Icons.exit_to_app_outlined,
          onTap: () => ConfirmDialog(
            message: 'Are you sure you want to stop nearby.',
            onConfirm: () => context.bloc<NearbyBloc>().add(const NearbyStopped()),
          ).openDialog(context),
        ),
        NearbyButton(
          label: 'Send\n SOS',
          color: Colors.red,
          icon: Icons.speaker_phone_outlined,
          onTap: () {
            _showSnackBar(context, 'SOS Sent');
            context.bloc<NearbyBloc>().sendSos();
          },
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
