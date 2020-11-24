import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    @required this.message,
    @required this.onConfirm,
    this.cancelText = 'NO',
    this.confirmText = 'YES',
  })  : assert(message != null),
        assert(onConfirm != null),
        assert(cancelText != null),
        assert(confirmText != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      duration: 200,
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
        title: const Icon(
          CommunityMaterialIcons.alert_rhombus,
          color: AppColors.secondary,
          size: 80.0,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message,
              style: context.t.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(child: _buildRejectButton(context)),
                const SizedBox(width: 12.0),
                Expanded(child: _buildConfirmButton(context)),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return CustomButton(
      label: confirmText,
      icon: Icons.check,
      color: context.c.secondaryVariant,
      backgroundColor: AppColors.secondaryLight,
      onTap: () {
        Navigator.of(context).pop();
        onConfirm();
      },
    );
  }

  Widget _buildRejectButton(BuildContext context) {
    return CustomButton(
      label: cancelText,
      icon: Icons.close,
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
