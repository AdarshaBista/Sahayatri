import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/widgets/nearby/connection_info.dart';
import 'package:sahayatri/ui/widgets/nearby/device_name_field.dart';

class NearbyForm extends StatelessWidget {
  const NearbyForm();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: _buildList(context),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        const Header(
          title: 'Nearby',
          fontSize: 20.0,
        ),
        const SizedBox(height: 6.0),
        Text(
          'Stay connected with your friends and get notified when someone is disconnected.',
          style: context.t.headline6,
        ),
        const SizedBox(height: 10.0),
        _buildBody(),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NearbyCubit, NearbyState>(
      listener: (context, state) {
        if (state is NearbyError) {
          context.openFlushBar(state.message, type: FlushbarType.error);
        }
      },
      builder: (context, state) {
        if (state is NearbyConnected) {
          return Provider<NearbyConnected>.value(
            value: state,
            child: const ConnectionInfo(),
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DeviceNameField(),
              const SizedBox(height: 12.0),
              _buildStartNearbyButton(context),
            ],
          );
        }
      },
    );
  }

  Widget _buildStartNearbyButton(BuildContext context) {
    return CustomButton(
      label: 'Start Nearby',
      icon: AppIcons.nearby,
      onTap: () {
        final name = context.read<PrefsCubit>().prefs.deviceName;
        if (name.isNotEmpty) {
          context.read<NearbyCubit>().startNearby(name);
        } else {
          const MessageDialog(message: 'Please set your device name first.')
              .openDialog(context);
        }
      },
    );
  }
}
