import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_button.dart';
import 'package:sahayatri/ui/shared/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/widgets/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/shared/widgets/dialogs/message_dialog.dart';

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
          onTap: () => context.bloc<NearbyBloc>().sendSos(),
        ),
      ],
    );
  }

  Widget _buildNearbyInitial(BuildContext context) {
    return CustomButton(
      label: 'Start Nearby',
      iconData: CommunityMaterialIcons.circle_double,
      onTap: () {
        final name = (context.bloc<PrefsBloc>().state as PrefsLoaded).prefs.deviceName;
        if (name.isNotEmpty) {
          context.bloc<NearbyBloc>().add(NearbyStarted(name: name));
        } else {
          const MessageDialog(message: 'Please set your device name first.')
              .openDialog(context);
        }
      },
    );
  }
}
