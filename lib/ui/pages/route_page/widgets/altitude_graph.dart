import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class AltitudeGraph extends StatelessWidget {
  final List<double> altitudes;
  final Function(int) onDrag;

  const AltitudeGraph({
    @required this.altitudes,
    @required this.onDrag,
  })  : assert(altitudes != null),
        assert(onDrag != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Altitude Graph',
            textAlign: TextAlign.center,
            style: AppTextStyles.medium,
          ),
          const SizedBox(height: 24.0),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
              child: _buildGraph(),
            ),
          ),
        ],
      ),
    );
  }

  LineChart _buildGraph() {
    const double interval = 1000.0;
    final double maxY = altitudes.reduce(math.max).toDouble();
    final List<double> xValues =
        List.generate(altitudes.length, (index) => index.toDouble()).toList();

    return LineChart(
      LineChartData(
        minY: 0.0,
        minX: 0.0,
        maxY: maxY,
        maxX: xValues.length.toDouble(),
        borderData: FlBorderData(show: false),
        lineTouchData: _buildTouchData(),
        gridData: _buildGrid(interval),
        titlesData: _buildTitles(interval),
        lineBarsData: [_buildLineData(xValues, altitudes, AppColors.primary)],
      ),
    );
  }

  LineTouchData _buildTouchData() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        fitInsideHorizontally: true,
        tooltipBgColor: AppColors.dark,
      ),
      touchCallback: (response) {
        if (response.lineBarSpots.isEmpty) return;
        final int index = response.lineBarSpots.first.spotIndex;
        onDrag(index);
      },
    );
  }

  FlGridData _buildGrid(double interval) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      drawHorizontalLine: true,
      verticalInterval: interval,
      horizontalInterval: interval,
    );
  }

  FlTitlesData _buildTitles(double interval) {
    return FlTitlesData(
      bottomTitles: SideTitles(showTitles: false),
      leftTitles: SideTitles(
        showTitles: true,
        margin: 8.0,
        interval: interval,
        reservedSize: 30.0,
        textStyle: AppTextStyles.extraSmall.bold,
        getTitles: (value) => '${value.round()}',
      ),
    );
  }

  LineChartBarData _buildLineData(
    List<double> xValues,
    List<double> yValues,
    Color color,
  ) {
    return LineChartBarData(
      spots: List<FlSpot>.generate(
        xValues.length,
        (index) => FlSpot(xValues[index], yValues[index]),
      ),
      barWidth: 0,
      isCurved: true,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      colors: [color],
      belowBarData: BarAreaData(
        show: true,
        colors: [
          color.withOpacity(0.7),
          color.withOpacity(0.5),
          color.withOpacity(0.3),
          color.withOpacity(0.0),
        ],
        gradientColorStops: [0.0, 0.5, 0.7, 1.0],
        gradientFrom: const Offset(0.5, 0.0),
        gradientTo: const Offset(0.5, 1.0),
      ),
    );
  }
}
