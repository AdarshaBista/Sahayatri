import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/dialogs/confirm_dialog.dart';

class UnsavedDialog extends StatelessWidget {
  const UnsavedDialog();

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      cancelText: 'BACK',
      confirmText: 'EXIT',
      message: 'Changes you made will not be saved!',
      onConfirm: Navigator.of(context).pop,
    );
  }
}