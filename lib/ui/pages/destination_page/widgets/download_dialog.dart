import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/buttons/custom_button.dart';
import 'package:sahayatri/ui/shared/dialogs/confirm_dialog.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/icon_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BlocProvider<DownloadCubit>(
        create: (context) => DownloadCubit(
          user: context.bloc<UserCubit>().user,
          destinationCubit: context.bloc<DestinationCubit>(),
          destinationsService: context.repository<DestinationsService>(),
        )..startDownload(context.bloc<DestinationCubit>().destination),
        child: Builder(
          builder: (context) {
            return ScaleAnimator(
              duration: 200,
              child: AlertDialog(
                elevation: 12.0,
                clipBehavior: Clip.antiAlias,
                backgroundColor: AppColors.light,
                title: BlocBuilder<DownloadCubit, DownloadState>(
                  builder: (context, state) {
                    if (state is DownloadCompleted) {
                      return _buildCompleted(context, state.message);
                    } else if (state is DownloadInProgress) {
                      return _buildProgress(context, state.message);
                    } else {
                      return const Offstage();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BusyIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        CustomButton(
          label: 'Cancel',
          iconData: Icons.close,
          backgroundColor: AppColors.secondary,
          onTap: () => ConfirmDialog(
            message: 'Are you sure you want to cancel the download?',
            onConfirm: () {
              context.bloc<DownloadCubit>().cancelDownload();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompleted(BuildContext context, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconIndicator(
          imageUrl: Images.kDownloaded,
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
          ),
        ),
        CustomButton(
          label: 'OK',
          outlineOnly: true,
          color: AppColors.dark,
          iconData: Icons.check,
          backgroundColor: AppColors.primary.withOpacity(0.3),
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
