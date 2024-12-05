import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_graph.dart';

class AltitudeGraph extends StatelessWidget {
  final Function(int) onDrag;
  final double routeLengthKm;
  final List<double> altitudes;

  const AltitudeGraph({
    super.key,
    required this.onDrag,
    required this.altitudes,
    required this.routeLengthKm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'ALTITUDE GRAPH',
            textAlign: TextAlign.center,
            style: context.t.headlineSmall?.bold,
          ),
          const SizedBox(height: 24.0),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
              child: _buildGraph(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(BuildContext context) {
    return CustomGraph(
      onTouch: onDrag,
      yValues: altitudes,
      vInterval: 1000.0,
      hInterval: altitudes.length / 4.0,
      getLeftTitle: (value) {
        return '${value.round()} m';
      },
      getBottomTitle: (value) {
        final double percent = value / altitudes.length;
        return '${(percent * routeLengthKm).round()} km';
      },
    );
  }
}
