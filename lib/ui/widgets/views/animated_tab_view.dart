import 'package:flutter/material.dart';

class AnimatedTabView extends StatefulWidget {
  final int index;
  final bool keepAlive;
  final List<Widget> children;

  const AnimatedTabView({
    required this.index,
    required this.children,
    this.keepAlive = false,
  });

  @override
  _AnimatedTabViewState createState() => _AnimatedTabViewState();
}

class _AnimatedTabViewState extends State<AnimatedTabView>
    with TickerProviderStateMixin {
  late int index;
  late final AnimationController fadeController;
  late final AnimationController scaleController;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(milliseconds: 150),
    );

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 100),
    );

    index = widget.index;
    fadeController.forward();
    scaleController.forward();
  }

  @override
  void didUpdateWidget(AnimatedTabView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != index) {
      fadeController.reverse();
      scaleController.reverse().then((_) {
        setState(() => index = widget.index);
        fadeController.forward();
        scaleController.forward();
      });
    }
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: scaleController,
        curve: Curves.ease,
      ),
      child: !widget.keepAlive
          ? widget.children[index]
          : IndexedStack(
              index: index,
              children: widget.children,
            ),
      builder: (context, child) {
        return FadeTransition(
          opacity: fadeController,
          child: Transform.scale(
            scale: 1.015 - (scaleController.value * 0.015),
            child: child,
          ),
        );
      },
    );
  }
}
