import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:animator/animator.dart';

class ScaleAnimator extends StatelessWidget {
  final Widget child;
  final int duration;

  const ScaleAnimator({
    required this.child,
    this.duration = UiConfig.animatorDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      child: child,
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: duration),
      builder: (context, animatorState, widget) => ScaleTransition(
        scale: animatorState.animation,
        child: widget,
      ),
    );
  }
}
