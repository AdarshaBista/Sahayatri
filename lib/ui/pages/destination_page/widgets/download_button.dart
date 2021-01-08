import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/column_button.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_dialog.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! Authenticated) return const Offstage();

        return BlocConsumer<DownloadCubit, DownloadState>(
          listener: (context, state) {
            if (state is DownloadError) {
              Navigator.of(context).pop();
              context.openFlushBar(state.message, type: FlushbarType.error);
            }
          },
          builder: (context, state) {
            if (state is DownloadCompleted) {
              return _buildDownloaded();
            } else if (state is DownloadInProgress) {
              return const CircularBusyIndicator();
            }
            return _buildDownload(context);
          },
        );
      },
    );
  }

  Widget _buildDownloaded() {
    return VerticalButton(
      onTap: () {},
      label: 'Downloaded',
      icon: AppIcons.downloadComplete,
    );
  }

  Widget _buildDownload(BuildContext context) {
    return VerticalButton(
      label: 'Download',
      icon: AppIcons.download,
      onTap: () {
        context.read<DownloadCubit>().startDownload();
        const DownloadDialog().openDialog(context, barrierDismissible: false);
      },
    );
  }
}
