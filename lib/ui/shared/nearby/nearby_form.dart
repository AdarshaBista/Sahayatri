import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/shared/nearby/connection_info.dart';
import 'package:sahayatri/ui/shared/nearby/device_name_field.dart';

class NearbyForm extends StatelessWidget {
  final bool isOnSettings;

  const NearbyForm({
    @required this.isOnSettings,
  }) : assert(isOnSettings != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: isOnSettings
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: _buildList(context),
                  ),
                )
              : _buildList(context),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: isOnSettings
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        Text(
          'Nearby',
          style: AppTextStyles.medium.bold,
        ),
        const SizedBox(height: 8.0),
        Text(
          'Stay connected with your friends and get notified when someone is disconnected.',
          style: AppTextStyles.extraSmall,
        ),
        const SizedBox(height: 10.0),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<NearbyCubit, NearbyState>(
      listener: (context, state) {
        if (state is NearbyError) context.openSnackBar(state.message);
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
      iconData: CommunityMaterialIcons.circle_double,
      onTap: () {
        final name = (context.bloc<PrefsCubit>().state as PrefsLoaded).prefs.deviceName;
        if (name.isNotEmpty) {
          context.bloc<NearbyCubit>().startNearby(name);
        } else {
          const MessageDialog(message: 'Please set your device name first.')
              .openDialog(context);
        }
      },
    );
  }
}
