import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class UnsavedDialog extends StatelessWidget {
  const UnsavedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      cancelIcon: AppIcons.back,
      confirmIcon: AppIcons.close,
      message: 'You have unsaved changes! Are you sure you want to go back?',
      onConfirm: Navigator.of(context).pop,
    );
  }
}
