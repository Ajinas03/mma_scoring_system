import 'package:flutter/material.dart';

import '../../models/participant.dart';
import 'widget/final_decision.dart';
import 'widget/referee_scores_list.dart';

class MainJuryScreen extends StatelessWidget {
  final String eventId;
  final List<Participant> participants;

  const MainJuryScreen({
    super.key,
    required this.eventId,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Jury Control'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefereeScoresList(
              eventId: eventId,
              participants: participants,
            ),
          ),
          FinalDecision(
            eventId: eventId,
            participants: participants,
          ),
        ],
      ),
    );
  }
}
