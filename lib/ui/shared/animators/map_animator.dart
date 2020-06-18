/// Credits: https://gist.github.com/avioli/a0b800d6a5ed053871ab4eec8f57c2da

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart' show MapController;

class MapAnimator {
  MapAnimator({
    @required this.mapController,
    @required TickerProvider tickerProvider,
    this.curve = Curves.fastOutSlowIn,
    this.duration = const Duration(milliseconds: 600),
  }) {
    _animationController = AnimationController(
      vsync: tickerProvider,
    )..addListener(onAnimationTick);
  }

  /// Holds a reference to the [MapController]
  final MapController mapController;

  /// Holds the default [Duration] for the animations
  final Duration duration;

  /// Holds the easing [Curve] for the animation
  final Curve curve;

  AnimationController _animationController;

  /// Provides the [AnimationController]
  AnimationController get animationController => _animationController;

  Animation<LatLng> _centerAnimation;
  Animation<double> _zoomAnimation;

  bool _willUpdateProp = false;

  /// Signifies if a prop is being updated
  bool get willUpdateProp => _willUpdateProp;

  bool _needsAnimation = false;

  /// Signifies if this instance needs to animate
  bool get needsAnimation => _needsAnimation;

  /// Animates a mapController.move to a given center (and zoom)
  TickerFuture move(LatLng center, [double zoom]) {
    assert(center != null);
    return animate(() {
      this.center = center;
      this.zoom = zoom ?? mapController.zoom;
    });
  }

  /// Release the resources used by this object. The object is no longer usable
  /// after this method is called.
  void dispose() {
    if (animationController.isAnimating) {
      animationController.stop();
    }
    animationController.dispose();
  }

  /// Animates the changed properties
  ///
  /// Changes can be made prior calling the method or within the [animator]
  /// callback.
  TickerFuture animate([Function animator]) => animateIn(duration, animator);

  /// Animates the changed properties, overriding the default [Duration]
  ///
  /// Changes can be made prior calling the method or within the [animator]
  /// callback.
  ///
  /// NOTE: Calling this method will stop any ongoing animation.
  /// Its [orCancel] future will be (silently) rejected.
  TickerFuture animateIn(Duration duration, [Function animator]) {
    assert(duration != null);
    if (animator != null) {
      animator();
    }
    if (needsAnimation) {
      _needsAnimation = false;
      return animationController.animateTo(
        animationController.upperBound,
        duration: duration,
      );
    }
    return TickerFuture.complete();
  }

  /// A convenience getter to get the map's center
  LatLng get center => mapController.center;

  /// Sets the map's center
  ///
  /// Must be set within an [animate] or [animateIn] callback, or the desired
  /// method must be called after the set to run the animation.
  set center(LatLng value) {
    assert(value != null);
    updateProp(() {
      _centerAnimation = animationFor(LatLngTween(
        begin: center,
        end: value,
      ))
        ..onEnd(() => _centerAnimation = null);
      _needsAnimation = true;
    });
  }

  /// A convenience getter to get the map's zoom level
  double get zoom => mapController.zoom;

  /// Sets the map's zoom level
  ///
  /// Must be set within an [animate] or [animateIn] callback, or the desired
  /// method must be called after the set to run the animation.
  set zoom(double value) {
    assert(value != null);
    updateProp(() {
      _zoomAnimation = animationFor(Tween<double>(
        begin: zoom,
        end: value,
      ))
        ..onEnd(() => _zoomAnimation = null);
      _needsAnimation = true;
    });
  }

  /// Returns an [Animation] by chaining the [tween] with the curve and
  /// attaching to the [AnimationController]
  @protected
  Animation<T> animationFor<T>(Tween<T> tween) {
    final curveTween = CurveTween(curve: curve);
    return tween.chain(curveTween).animate(animationController);
  }

  /// Runs on every animation tick to adjust the map's center and/or zoom
  @protected
  void onAnimationTick() {
    if (willUpdateProp) {
      // NOTE: ignore the value reset
      return;
    }
    if (_centerAnimation == null && _zoomAnimation == null) {
      return;
    }
    mapController.move(
      _centerAnimation?.value ?? mapController.center,
      _zoomAnimation?.value ?? mapController.zoom,
    );
  }

  /// Resets the [AnimationController], if needed
  ///
  /// It ensures the [AnimationController] is reset, but retain
  /// the [MapController]'s center and zoom.
  @protected
  void updateProp(Function callback) {
    _willUpdateProp = true;
    if (animationController.value != 0.0 || animationController.isAnimating) {
      animationController.value = 0.0;
    }
    try {
      callback();
    } finally {
      _willUpdateProp = false;
    }
  }
}

/// An interpolation between two LatLng instances.
///
/// See [Tween] for a discussion on how to use interpolation objects.
class LatLngTween extends Tween<LatLng> {
  /// Creates a [LatLng] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as an empty LatLng.
  LatLngTween({LatLng begin, LatLng end}) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  LatLng lerp(double t) {
    assert(t != null);
    if (begin == null && end == null) return null;
    double lat, lng;
    if (begin == null) {
      lat = end.latitude * t;
      lng = end.longitude * t;
    } else if (end == null) {
      lat = begin.latitude * (1.0 - t);
      lng = begin.longitude * (1.0 - t);
    } else {
      lat = lerpDouble(begin.latitude, end.latitude, t);
      lng = lerpDouble(begin.longitude, end.longitude, t);
    }
    return LatLng(lat, lng);
  }

  @protected
  double lerpDouble(double a, double b, double t) {
    if (a == null && b == null) return null;
    final double start = a ?? 0.0;
    final double end = b ?? 0.0;
    return start + (end - start) * t;
  }
}

extension EndListener<T> on Animation<T> {
  /// Adds a one-off `completed/dismissed` listener that is automatically
  /// removed
  Function onEnd(Function callback) {
    AnimationStatusListener wrapper;
    wrapper = (AnimationStatus status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        removeStatusListener(wrapper);
        callback();
      }
    };
    addStatusListener(wrapper);
    return () {
      removeStatusListener(wrapper);
    };
  }
}
