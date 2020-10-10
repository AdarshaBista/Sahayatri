import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/dialogs/message_dialog.dart';
import 'package:sahayatri/ui/widgets/nearby/connection_info.dart';
import 'package:sahayatri/ui/widgets/nearby/device_name_field.dart';

class TranslateForm extends StatelessWidget {
  final bool isOnSettings;

  const TranslateForm({
    @required this.isOnSettings,
  }) : assert(isOnSettings != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: isOnSettings
            ? SlideAnimator(
                begin: const Offset(0.0, 1.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: _buildList(context),
                  ),
                ),
              )
            : _buildList(context),
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
        Text('Translate', style: AppTextStyles.medium.bold),
        const SizedBox(height: 8.0),
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
      backgroundColor: AppColors.primaryDark,
      iconData: CommunityMaterialIcons.circle_double,
      onTap: () {
        final name = context.bloc<PrefsCubit>().prefs.deviceName;
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
