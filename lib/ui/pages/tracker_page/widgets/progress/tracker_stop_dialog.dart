import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:community_material_icon/community_material_icon.dart';

class TrackerStopDialog extends StatelessWidget {
  final VoidCallback onStop;

  const TrackerStopDialog({
    @required this.onStop,
  }) : assert(onStop != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 12.0,
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.background,
      contentPadding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
      title: const Icon(
        CommunityMaterialIcons.alert_circle_outline,
        color: AppColors.secondary,
        size: 72.0,
      ),
      content: Text(
        'Are you sure you want to stop the tracking process.',
        style: AppTextStyles.small,
      ),
      actions: [
        _buildYesButton(context),
        _buildNoButton(context),
      ],
    );
  }

  Widget _buildYesButton(BuildContext context) {
    return FlatButton(
      child: Text(
        'YES',
        style: AppTextStyles.small.primary.bold,
      ),
      onPressed: () {
        onStop();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildNoButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        'NO',
        style: AppTextStyles.small.secondary.bold,
      ),
    );
  }
}
