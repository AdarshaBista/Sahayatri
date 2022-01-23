import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/extensions/route_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class RouteLayer extends StatefulWidget {
  final MapController mapController;

  const RouteLayer({
    required this.mapController,
  }) : assert(mapController != null);

  @override
  _RouteLayerState createState() => _RouteLayerState();
}

class _RouteLayerState extends State<RouteLayer> {
  double zoom;
  bool shouldSimplifyRoute = false;
  StreamSubscription mapEventSubscription;

  @override
  void initState() {
    super.initState();
    zoom = widget.mapController.zoom;

    mapEventSubscription = widget.mapController.mapEventStream.listen((event) {
      if (event.zoom != zoom) {
        zoom = event.zoom;
        shouldSimplifyRoute = true;
      }
    });
  }

  @override
  void dispose() {
    mapEventSubscription.cancel();
    super.dispose();
  }

  void onPointerUp() {
    if (shouldSimplifyRoute) {
      setState(() {
        shouldSimplifyRoute = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers.route != c.prefs.mapLayers.route,
      builder: (context, state) {
        final enabled = state.prefs.mapLayers.route;
        if (!enabled) return const SizedBox();

        final destination = context.watch<Destination>();
        return Listener(
          onPointerUp: (_) => onPointerUp(),
          child: ScaleAnimator(
            child: PolylineLayerWidget(
              options: PolylineLayerOptions(
                polylines: [
                  Polyline(
                    strokeWidth: 4.0,
                    gradientColors: AppColors.routeGradient,
                    points: destination.route
                        .simplify(zoom)
                        .map((c) => c.toLatLng())
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
