import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomGraph extends StatelessWidget {
  final Color color;
  final double vInterval;
  final double hInterval;
  final List<double> yValues;
  final bool showGrid;
  final bool showBorder;
  final bool showLeftLabels;
  final bool showBottomLabels;
  final double? height;
  final List<double>? xValues;
  final Function(int)? onTouch;
  final String Function(double)? getLeftTitle;
  final String Function(double)? getBottomTitle;

  const CustomGraph({
    super.key,
    required this.yValues,
    this.xValues,
    this.height,
    this.vInterval = 1.0,
    this.hInterval = 1.0,
    this.showGrid = true,
    this.showBorder = true,
    this.showLeftLabels = true,
    this.showBottomLabels = true,
    this.color = AppColors.primary,
    this.onTouch,
    this.getLeftTitle,
    this.getBottomTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (height == null) return _buildGraph(context);
    return SizedBox(
      height: height,
      child: _buildGraph(context),
    );
  }

  LineChart _buildGraph(BuildContext context) {
    final double maxY = yValues.reduce(math.max).toDouble();
    final double minY = yValues.reduce(math.min).toDouble();
    final double decreasedMinY = minY - (maxY - minY);
    final double effectiveMinY = decreasedMinY > 0 ? decreasedMinY : minY;
    final double effectiveMaxX =
        (xValues?.length ?? yValues.length).toDouble() - 1.0;

    return LineChart(
      LineChartData(
        minY: effectiveMinY,
        maxY: maxY,
        minX: 0.0,
        maxX: effectiveMaxX,
        gridData: _buildGrid(),
        lineTouchData: _buildTouchData(),
        titlesData: _buildTitles(context),
        borderData: _buildBorderData(context),
        lineBarsData: [_buildLineData()],
      ),
      swapAnimationDuration: Duration.zero,
    );
  }

  FlBorderData _buildBorderData(BuildContext context) {
    return FlBorderData(
      show: showBorder,
      border: Border.all(
        width: 0.5,
        color: context.c.onSurface,
      ),
    );
  }

  LineTouchData _buildTouchData() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipRoundedRadius: 32.0,
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        tooltipBgColor: AppColors.dark,
      ),
      touchCallback: (_, response) {
        if (response == null || response.lineBarSpots == null) return;
        if (onTouch == null || (response.lineBarSpots!.isEmpty)) return;

        final int index = response.lineBarSpots!.first.spotIndex;
        onTouch?.call(index);
      },
    );
  }

  FlGridData _buildGrid() {
    return FlGridData(
      show: showGrid,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      verticalInterval: hInterval,
      horizontalInterval: vInterval,
    );
  }

  FlTitlesData _buildTitles(BuildContext context) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showBottomLabels,
          reservedSize: 30.0,
          interval: hInterval,
          getTitlesWidget: getBottomTitle == null
              ? null
              : (value, meta) {
                  return Text(
                    getBottomTitle!(value),
                    style: context.t.headline6?.bold,
                  );
                },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showLeftLabels,
          reservedSize: 30.0,
          interval: vInterval,
          getTitlesWidget: getLeftTitle == null
              ? null
              : (value, meta) {
                  return Text(
                    getLeftTitle!(value),
                    style: context.t.headline6?.bold,
                  );
                },
        ),
      ),
    );
  }

  LineChartBarData _buildLineData() {
    final effectiveXValues = xValues ??
        List.generate(yValues.length, (index) => index.toDouble()).toList();

    return LineChartBarData(
      spots: List<FlSpot>.generate(
        effectiveXValues.length,
        (index) => FlSpot(effectiveXValues[index], yValues[index]),
      ),
      barWidth: 2.0,
      isCurved: true,
      isStrokeCapRound: true,
      preventCurveOverShooting: true,
      dotData: FlDotData(show: false),
      color: color,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          end: const Alignment(0.5, 1.0),
          begin: const Alignment(0.5, 0.0),
          stops: const [0.0, 0.2, 1.0],
          colors: [
            color.withOpacity(0.7),
            color.withOpacity(0.4),
            color.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}
