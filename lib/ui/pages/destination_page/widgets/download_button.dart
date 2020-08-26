import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/extensions/widget_x.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/buttons/column_button.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/download_dialog.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton();

  @override
  Widget build(BuildContext context) {
    if (!context.bloc<UserCubit>().isAuthenticated) return const Offstage();

    return BlocBuilder<DestinationCubit, Destination>(
      builder: (context, destination) {
        return _buildButton(context, destination);
      },
    );
  }

  Widget _buildButton(BuildContext context, Destination destination) {
    return destination.isDownloaded
        ? ColumnButton(
            label: 'Downloaded',
            icon: CommunityMaterialIcons.check_circle_outline,
            onTap: () {},
          )
        : ColumnButton(
            label: 'Download',
            icon: CommunityMaterialIcons.cloud_download_outline,
            onTap: () => const DownloadDialog().openDialog(
              context,
              barrierDismissible: false,
            ),
          );
  }
}
