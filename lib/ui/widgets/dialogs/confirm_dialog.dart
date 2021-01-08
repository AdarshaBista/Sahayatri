import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/custom_button.dart';
import 'package:sahayatri/ui/widgets/dialogs/custom_dialog.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final String cancelText;
  final String confirmText;
  final IconData cancelIcon;
  final IconData confirmIcon;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    @required this.message,
    @required this.onConfirm,
    this.cancelText = 'NO',
    this.confirmText = 'YES',
    this.cancelIcon = AppIcons.close,
    this.confirmIcon = AppIcons.confirm,
  })  : assert(message != null),
        assert(onConfirm != null),
        assert(cancelText != null),
        assert(confirmText != null),
        assert(cancelIcon != null),
        assert(confirmIcon != null);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
      child: const Icon(
        AppIcons.alert,
        size: 80.0,
        color: AppColors.secondary,
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
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return CustomButton(
      icon: confirmIcon,
      label: confirmText,
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
      icon: cancelIcon,
      label: cancelText,
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
