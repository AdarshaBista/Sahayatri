import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/ui/widgets/animators/map_animator.dart';

class AnimatedLatLng extends StatefulWidget {
  final Coord begin;
  final Coord end;
  final Widget Function(LatLng) builder;

  const AnimatedLatLng({
    super.key,
    required this.begin,
    required this.end,
    required this.builder,
  });

  @override
  State<AnimatedLatLng> createState() => _AnimatedLatLngState();
}

class _AnimatedLatLngState extends State<AnimatedLatLng> with SingleTickerProviderStateMixin {
  late final Animation<LatLng> animation;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = LatLngTween(
      begin: widget.begin.toLatLng(),
      end: widget.end.toLatLng(),
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedLatLng oldWidget) {
    super.didUpdateWidget(oldWidget);

    animation = LatLngTween(
      begin: widget.begin.toLatLng(),
      end: widget.end.toLatLng(),
    ).animate(animationController);

    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return widget.builder(animation.value);
      },
    );
  }
}
