import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class UnsavedDialog extends StatelessWidget {
  const UnsavedDialog();

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      confirmIcon: Icons.close,
      cancelIcon: Icons.keyboard_arrow_left,
      message: 'You have unsaved changes! Are you sure you want to go back?',
      onConfirm: Navigator.of(context).pop,
    );
  }
}
