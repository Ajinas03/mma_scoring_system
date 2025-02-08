import 'package:flutter/material.dart';
import 'package:my_app/models/round_analytics_model.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';

import '../../utils/winner_confirmation_dialogue.dart';
import 'widgets/referee_marks_chart.dart';

class RoundAnalyticsDisplay extends StatefulWidget {
  final RoundAnalyticsModel roundAnalytics;

  const RoundAnalyticsDisplay({super.key, required this.roundAnalytics});

  @override
  State<RoundAnalyticsDisplay> createState() => _RoundAnalyticsDisplayState();
}

class _RoundAnalyticsDisplayState extends State<RoundAnalyticsDisplay> {
  void _showWinnerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return WinnerConfirmationDialog(
          playerName: "Red",
          onConfirm: (selectedOption) {
            // Handle the selected option here
            print('Winner selected: $selectedOption');

            // Show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Winner confirmed: $selectedOption'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.red.withOpacity(0.8),
              onPressed: () {
                _showWinnerDialog(context);
              },
              label: TextWidget(text: "Red Win")),
          FloatingActionButton.extended(
              backgroundColor: Colors.grey,
              onPressed: () {},
              label: TextWidget(
                text: "Draw",
                color: Colors.black,
              )),
          FloatingActionButton.extended(
              backgroundColor: Colors.blue.withOpacity(0.8),
              onPressed: () {},
              label: TextWidget(text: "Blue Win"))
        ],
      ),
      appBar: secondaryAppBar(title: 'Round Analytics'),
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.roundAnalytics.roundedScores.length,
            itemBuilder: (context, index) {
              RoundedScore score = widget.roundAnalytics.roundedScores[index];
              return RoundScoreCard(score: score);
            },
          ),
          RefereeMarksChart(roundedScores: widget.roundAnalytics.roundedScores)
        ],
      ),
    );
  }
}

// Custom Card Widget for Each Round Score
class RoundScoreCard extends StatelessWidget {
  final RoundedScore score;

  const RoundScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Round Position: ${score.position}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Red Team Score', style: TextStyle(color: Colors.red)),
                    Text('${score.redTotalRoundedScore}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Blue Team Score',
                        style: TextStyle(color: Colors.blue)),
                    Text('${score.blueTotalRoundedScore}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Winner: ${score.won}'),
                Text('Win Type: ${score.wonType}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
