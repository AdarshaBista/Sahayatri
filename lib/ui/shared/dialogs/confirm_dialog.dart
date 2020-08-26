import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    @required this.message,
    @required this.onConfirm,
  })  : assert(message != null),
        assert(onConfirm != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: SlideAnimator(
        begin: const Offset(0.0, 0.5),
        child: AlertDialog(
          elevation: 12.0,
          clipBehavior: Clip.antiAlias,
          backgroundColor: AppColors.light,
          contentPadding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
          title: const Icon(
            CommunityMaterialIcons.alert_circle_outline,
            color: AppColors.secondary,
            size: 72.0,
          ),
          content: Text(
            message,
            style: AppTextStyles.small,
            textAlign: TextAlign.center,
          ),
          actions: [
            _buildConfirmButton(context),
            _buildRejectButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return FlatButton(
      child: Text(
        'YES',
        style: AppTextStyles.small.secondary.bold,
      ),
      onPressed: () {
        onConfirm();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildRejectButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        'NO',
        style: AppTextStyles.small.primary.bold,
      ),
    );
  }
}
