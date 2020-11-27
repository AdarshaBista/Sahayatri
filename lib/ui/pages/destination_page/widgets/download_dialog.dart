import 'package:flutter/material.dart';

import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:sahayatri/app/constants/images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/custom_dialog.dart';
import 'package:sahayatri/ui/widgets/indicators/icon_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BlocProvider<DownloadCubit>(
        create: (context) => DownloadCubit(
          user: context.read<UserCubit>().user,
          destinationCubit: context.read<DestinationCubit>(),
          destinationsService: context.read<DestinationsService>(),
        )..startDownload(context.read<DestinationCubit>().destination),
        child: Builder(
          builder: (context) {
            return CustomDialog(
              child: BlocBuilder<DownloadCubit, DownloadState>(
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
        const BusyIndicator(
          padding: 16.0,
          imageUrl: Images.downloadLoading,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildCompleted(BuildContext context, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconIndicator(
          padding: 16.0,
          imageUrl: Images.downloadComplete,
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: context.t.headline5.bold,
          ),
        ),
        CustomButton(
          label: 'OK',
          icon: Icons.check,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
