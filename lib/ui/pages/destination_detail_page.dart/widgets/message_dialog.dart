import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/indicators/message_indicator.dart';

class MessageDialog extends StatelessWidget {
  final String message;

  const MessageDialog({
    @required this.message,
  }) : assert(message != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      duration: 200,
      child: AlertDialog(
        elevation: 12.0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.light,
        title: MessageIndicator(message: message),
      ),
    );
  }
}
