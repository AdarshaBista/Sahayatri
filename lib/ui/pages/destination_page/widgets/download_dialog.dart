import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/images.dart';

import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/custom_dialog.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Builder(
        builder: (context) {
          return CustomDialog(
            child: BlocBuilder<DownloadCubit, DownloadState>(
              builder: (context, state) {
                if (state is DownloadCompleted) {
                  return _buildCompleted(context);
                } else if (state is DownloadInProgress) {
                  return _buildProgress(context, state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgress(BuildContext context, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BusyIndicator(
          padding: 16.0,
          imageUrl: Images.downloadLoading,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.t.headlineSmall?.bold,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildCompleted(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconIndicator(
          padding: 16.0,
          imageUrl: Images.downloadComplete,
          title: Text(
            'Download Complete!',
            textAlign: TextAlign.center,
            style: context.t.headlineSmall?.bold,
          ),
        ),
        CustomButton(
          label: 'OK',
          icon: AppIcons.confirm,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
