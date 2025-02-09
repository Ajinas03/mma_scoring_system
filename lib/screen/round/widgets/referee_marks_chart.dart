import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/round_analytics_model.dart';

class RefereePointsChart extends StatelessWidget {
  final List<RoundedScore> roundedScores;

  const RefereePointsChart({
    super.key,
    required this.roundedScores,
  });

  @override
  Widget build(BuildContext context) {
    // Process data for the chart
    List<RefereePointData> chartData = roundedScores.map((score) {
      return RefereePointData(
        referee: score.position.replaceAll('Referee', ''),
        redPoints: score.redTotalRoundedScore.toDouble(),
        bluePoints: score.blueTotalRoundedScore.toDouble(),
      );
    }).toList();

    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        // Legend configuration
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),

        // Primary X axis (Referees)
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Referee Positions'),
          labelRotation: 0,
        ),

        // Primary Y axis (Points)
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Total Points'),
          // Set dynamic minimum and maximum based on data
          minimum: _getMinValue(chartData),
          maximum: _getMaxValue(chartData),
          interval: 2,
        ),

        // Enable tooltips
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Total points: point.y',
        ),

        // Series data
        series: <CartesianSeries<RefereePointData, String>>[
          // Red points column series
          ColumnSeries<RefereePointData, String>(
            name: 'Red Corner',
            dataSource: chartData,
            xValueMapper: (RefereePointData data, _) => data.referee,
            yValueMapper: (RefereePointData data, _) => data.redPoints,
            color: Colors.red.withOpacity(0.8),
            width: 0.4,
            spacing: 0.2,
            borderRadius: BorderRadius.circular(4),
          ),

          // Blue points column series
          ColumnSeries<RefereePointData, String>(
            name: 'Blue Corner',
            dataSource: chartData,
            xValueMapper: (RefereePointData data, _) => data.referee,
            yValueMapper: (RefereePointData data, _) => data.bluePoints,
            color: Colors.blue.withOpacity(0.8),
            width: 0.4,
            spacing: 0.2,
            borderRadius: BorderRadius.circular(4),
          ),
        ],

        // Additional chart customization
        plotAreaBorderWidth: 0,
        enableAxisAnimation: true,
      ),
    );
  }

  // Helper method to get minimum value for y-axis
  double _getMinValue(List<RefereePointData> data) {
    double min = double.infinity;
    for (var item in data) {
      if (item.redPoints < min) min = item.redPoints;
      if (item.bluePoints < min) min = item.bluePoints;
    }
    return (min - 2).floorToDouble(); // Add some padding
  }

  // Helper method to get maximum value for y-axis
  double _getMaxValue(List<RefereePointData> data) {
    double max = double.negativeInfinity;
    for (var item in data) {
      if (item.redPoints > max) max = item.redPoints;
      if (item.bluePoints > max) max = item.bluePoints;
    }
    return (max + 2).ceilToDouble(); // Add some padding
  }
}

// Data model for chart
class RefereePointData {
  final String referee;
  final double redPoints;
  final double bluePoints;

  RefereePointData({
    required this.referee,
    required this.redPoints,
    required this.bluePoints,
  });
}
