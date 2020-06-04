import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:animator/animator.dart';

class ScaleAnimator extends StatelessWidget {
  final Widget child;
  final int duration;

  const ScaleAnimator({
    @required this.child,
    this.duration = Values.kAnimatorDuration,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: duration),
      builder: (context, animatorState, _) => Transform.scale(
        scale: animatorState.value,
        child: child,
      ),
    );
  }
}
