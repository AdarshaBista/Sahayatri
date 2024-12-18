import 'package:flutter/material.dart';

import 'package:animator/animator.dart';

import 'package:sahayatri/core/constants/configs.dart';

class FadeAnimator extends StatelessWidget {
  final Widget child;
  final int duration;

  const FadeAnimator({
    super.key,
    required this.child,
    this.duration = UiConfig.animatorDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      child: child,
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: duration),
      builder: (context, animatorState, widget) => FadeTransition(
        opacity: animatorState.animation,
        child: widget,
      ),
    );
  }
}
