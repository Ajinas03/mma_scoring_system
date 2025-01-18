import 'package:flutter/material.dart';

import '../../models/participant.dart';
import 'widgets/score_display.dart';
import 'widgets/scoring_button.dart';

class RefereeScoreScreen extends StatelessWidget {
  final String eventId;
  final String refereeId;
  final List<Participant> participants;

  const RefereeScoreScreen({
    super.key,
    required this.eventId,
    required this.refereeId,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referee Scoring'),
      ),
      body: Column(
        children: [
          ScoreDisplay(participants: participants),
          Expanded(
            child: ScoringButtons(
              eventId: eventId,
              refereeId: refereeId,
              participants: participants,
            ),
          ),
        ],
      ),
    );
  }
}
