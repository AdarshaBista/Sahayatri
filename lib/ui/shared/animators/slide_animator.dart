import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/values.dart';

import 'package:animator/animator.dart';

class SlideAnimator extends StatelessWidget {
  final int duration;
  final Offset begin;
  final Widget child;

  const SlideAnimator({
    @required this.child,
    @required this.begin,
    this.duration = Values.kAnimatorDuration,
  })  : assert(child != null),
        assert(begin != null),
        assert(duration != null);

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
