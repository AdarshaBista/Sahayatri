import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:sahayatri/ui/styles/styles.dart';

class AltitudeGraph extends StatelessWidget {
  final Function(int) onDrag;
  final double routeLengthKm;
  final List<double> altitudes;

  const AltitudeGraph({
    @required this.onDrag,
    @required this.altitudes,
    @required this.routeLengthKm,
  })  : assert(onDrag != null),
        assert(altitudes != null),
        assert(routeLengthKm != null);

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
            'Elevation Gain',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.bold,
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
    const double vInterval = 1000.0;
    final double hInterval = altitudes.length / 4.0;

    final List<double> xValues =
        List.generate(altitudes.length, (index) => index.toDouble()).toList();

    final double maxY = altitudes.reduce(math.max).toDouble();
    final double minY = altitudes.reduce(math.min).toDouble();
    final double decreasedMinY = minY - (maxY - minY);
    final double effectiveMinY = decreasedMinY > 0 ? decreasedMinY : minY;

    return LineChart(
      LineChartData(
        minY: effectiveMinY,
        maxY: maxY,
        minX: 0.0,
        maxX: xValues.length.toDouble(),
        borderData: _buildBorderData(),
        lineTouchData: _buildTouchData(),
        gridData: _buildGrid(vInterval, hInterval),
        titlesData: _buildTitles(vInterval, hInterval, xValues.length),
        lineBarsData: [_buildLineData(xValues, altitudes, AppColors.primary)],
      ),
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      border: Border.all(
        width: 0.5,
        color: AppColors.darkFaded,
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

  FlGridData _buildGrid(double vInterval, double hInterval) {
    return FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      verticalInterval: hInterval,
      horizontalInterval: vInterval,
    );
  }

  FlTitlesData _buildTitles(double vInterval, double hInterval, int length) {
    return FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        margin: 8.0,
        interval: hInterval,
        reservedSize: 30.0,
        getTextStyles: (_) => AppTextStyles.extraSmall.bold,
        getTitles: (value) {
          final double percent = value / length;
          return '${(percent * routeLengthKm).round()} km';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        margin: 8.0,
        interval: vInterval,
        reservedSize: 30.0,
        getTextStyles: (_) => AppTextStyles.extraSmall.bold,
        getTitles: (value) => '${value.round()} m',
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
      barWidth: 1.0,
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
