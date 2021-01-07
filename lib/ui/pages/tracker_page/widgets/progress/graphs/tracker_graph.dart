import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
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
    final length = yValues.length;

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
          child: CustomCard(
            borderRadius: 12.0,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomGraph(
              yValues: yValues.getRange(length - 20, length).toList(),
              color: color,
              height: 72.0,
              showGrid: false,
              showBorder: false,
              showLeftLabels: false,
              showBottomLabels: false,
            ),
          ),
        ),
      ],
    );
  }
}
