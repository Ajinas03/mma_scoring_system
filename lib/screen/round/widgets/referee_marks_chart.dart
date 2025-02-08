import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/round_analytics_model.dart';

class RefereeMarksChart extends StatelessWidget {
  final List<RoundedScore> roundedScores;

  const RefereeMarksChart({
    super.key,
    required this.roundedScores,
  });

  @override
  Widget build(BuildContext context) {
    // Process data for the chart
    List<RefereeMarkData> chartData = roundedScores.map((score) {
      // Calculate average marks for red and blue
      double redAverage = score.markDetails
              .where((detail) => detail.ismarkedToRed)
              .map((detail) => detail.mark)
              .reduce((a, b) => a + b) /
          score.markDetails.where((detail) => detail.ismarkedToRed).length;

      double blueAverage = score.markDetails
              .where((detail) => !detail.ismarkedToRed)
              .map((detail) => detail.mark)
              .reduce((a, b) => a + b) /
          score.markDetails.where((detail) => !detail.ismarkedToRed).length;

      return RefereeMarkData(
        referee: score.position.replaceAll('Referee', ''),
        redMarks: redAverage,
        blueMarks: blueAverage,
      );
    }).toList();

    return Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        // Chart title
        // title: ChartTitle(
        //   text: 'Referee Scoring Analysis',
        //   textStyle: const TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),

        // Legend
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),

        // Primary X axis (Referees)
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Referee Positions'),
          labelRotation: 0,
        ),

        // Primary Y axis (Marks)
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Average Marks'),
          minimum: 0,
          maximum: 10,
          interval: 1,
        ),

        // Enable tooltips
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'Average marks: point.y',
        ),

        // Series data
        series: <CartesianSeries<RefereeMarkData, String>>[
          // Red marks column series
          ColumnSeries<RefereeMarkData, String>(
            name: 'Red Corner',
            dataSource: chartData,
            xValueMapper: (RefereeMarkData data, _) => data.referee,
            yValueMapper: (RefereeMarkData data, _) => data.redMarks,
            color: Colors.red,
            width: 0.4,
            spacing: 0.2,
          ),

          // Blue marks column series
          ColumnSeries<RefereeMarkData, String>(
            name: 'Blue Corner',
            dataSource: chartData,
            xValueMapper: (RefereeMarkData data, _) => data.referee,
            yValueMapper: (RefereeMarkData data, _) => data.blueMarks,
            color: Colors.blue,
            width: 0.4,
            spacing: 0.2,
          ),
        ],
      ),
    );
  }
}

// Data model for chart
class RefereeMarkData {
  final String referee;
  final double redMarks;
  final double blueMarks;

  RefereeMarkData({
    required this.referee,
    required this.redMarks,
    required this.blueMarks,
  });
}
