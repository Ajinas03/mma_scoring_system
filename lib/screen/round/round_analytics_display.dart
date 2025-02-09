import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';
import 'package:my_app/models/round_analytics_model.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';

import '../../utils/winner_confirmation_dialogue.dart';
import 'widgets/referee_marks_chart.dart';

class RoundAnalyticsDisplay extends StatefulWidget {
  final String eventId;
  const RoundAnalyticsDisplay({super.key, required this.eventId});

  @override
  State<RoundAnalyticsDisplay> createState() => _RoundAnalyticsDisplayState();
}

class _RoundAnalyticsDisplayState extends State<RoundAnalyticsDisplay> {
  void _showWinnerDialog(BuildContext context, String pName) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return WinnerConfirmationDialog(
          playerName: pName,
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

  Future<bool> _onWillPop() async {
    // Get the current state before popping
    final eventState = context.read<EventBloc>().state;
    final roundAnalytics = eventState.roundAnalyticsModel;

    // Perform any cleanup or state updates
    if (roundAnalytics != null) {
      // You can dispatch an event to your bloc here if needed
      // For example, to clear or update certain data
      context.read<EventBloc>().add(GetCompetetion(eventId: widget.eventId));
    }

    // You can also save any data to SharedPrefs if needed
    // await SharedPrefsConfig.setString('last_viewed_round', someValue);

    // Show a confirmation dialog if needed
    // final shouldPop = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Are you sure?'),
    //     content: Text('Do you want to leave this page?'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: Text('No'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, true),
    //         child: Text('Yes'),
    //       ),
    //     ],
    //   ),
    // ) ?? false;
    // return shouldPop;

    // Return true to allow pop, false to prevent pop
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole) == "jury"
                ? SizedBox.shrink()
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton.extended(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          onPressed: () {
                            _showWinnerDialog(context, "Red");
                          },
                          label: TextWidget(text: "Red Win")),
                      FloatingActionButton.extended(
                          backgroundColor: Colors.grey,
                          onPressed: () {
                            _showWinnerDialog(context, "Draw");
                          },
                          label: TextWidget(
                            text: "Draw",
                            color: Colors.black,
                          )),
                      FloatingActionButton.extended(
                          backgroundColor: Colors.blue.withOpacity(0.8),
                          onPressed: () {
                            _showWinnerDialog(context, "Blue");
                          },
                          label: TextWidget(text: "Blue Win"))
                    ],
                  ),
        appBar: secondaryAppBar(title: 'Round Analytics'),
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            final roundAnalytics = state.roundAnalyticsModel;

            if (roundAnalytics == null ||
                roundAnalytics.roundedScores.isEmpty) {
              return const Center(
                child: Text('No analytics data available'),
              );
            }
            return ListView(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: roundAnalytics.roundedScores.length,
                  itemBuilder: (context, index) {
                    RoundedScore score = roundAnalytics.roundedScores[index];
                    return RoundScoreCard(score: score);
                  },
                ),
                RefereePointsChart(roundedScores: roundAnalytics.roundedScores)
              ],
            );
          },
        ),
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
