import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;
  final Widget content;
  final EdgeInsets padding;

  const CustomDialog({
    this.content,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
  })  : assert(child != null),
        assert(padding != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      duration: 200,
      child: AlertDialog(
        title: child,
        content: content,
        elevation: 12.0,
        titlePadding: padding,
        contentPadding: padding,
        clipBehavior: Clip.antiAlias,
        backgroundColor: context.theme.cardColor,
      ),
    );
  }
}
