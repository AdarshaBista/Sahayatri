import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/dialogs/custom_dialog.dart';
import 'package:sahayatri/ui/widgets/indicators/message_indicator.dart';

class MessageDialog extends StatelessWidget {
  final String message;

  const MessageDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: MessageIndicator(message: message),
    );
  }
}
