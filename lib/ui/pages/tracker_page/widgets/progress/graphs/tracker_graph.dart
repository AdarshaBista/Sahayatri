import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_graph.dart';

class TrackerGraph extends StatelessWidget {
  final Color color;
  final String title;
  final List<double> yValues;

  const TrackerGraph({
    @required this.title,
    @required this.color,
    @required this.yValues,
  })  : assert(title != null),
        assert(color != null),
        assert(yValues != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Flexible(
          child: CustomGraph(
            yValues: yValues,
            color: color,
            height: 72.0,
            showGrid: false,
            showBorder: false,
            showLeftLabels: false,
            showBottomLabels: false,
          ),
        ),
      ],
    );
  }
}
