import 'package:flutter/material.dart';

import 'package:animator/animator.dart';

import 'package:sahayatri/core/constants/configs.dart';

class SlideAnimator extends StatelessWidget {
  final int duration;
  final Offset begin;
  final Widget child;

  const SlideAnimator({
    super.key,
    required this.child,
    required this.begin,
    this.duration = UiConfig.animatorDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Animator<Offset>(
      child: child,
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: duration),
      tween: Tween<Offset>(begin: begin, end: Offset.zero),
      builder: (context, animatorState, widget) => SlideTransition(
        position: animatorState.animation,
        child: widget,
      ),
    );
  }
}
