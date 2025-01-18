import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../models/participant.dart';

class FinalDecision extends StatelessWidget {
  final String eventId;
  final List<Participant> participants;

  const FinalDecision({
    super.key,
    required this.eventId,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    final redCornerParticipant =
        participants.firstWhere((p) => p.corner == 'red');
    final blueCornerParticipant =
        participants.firstWhere((p) => p.corner == 'blue');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Final Decision',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      _submitDecision(context, redCornerParticipant.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redCorner,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '${redCornerParticipant.name}\nWins',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _submitDecision(context, 'draw'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Draw'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      _submitDecision(context, blueCornerParticipant.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueCorner,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '${blueCornerParticipant.name}\nWins',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitDecision(BuildContext context, String winnerId) {
    // TODO: Implement WebSocket call to submit final decision
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Decision'),
        content: Text(winnerId == 'draw'
            ? 'Are you sure you want to declare this match a draw?'
            : 'Are you sure you want to declare ${participants.firstWhere((p) => p.id == winnerId).name} as the winner?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Submit final decision via WebSocket
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to events list
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
