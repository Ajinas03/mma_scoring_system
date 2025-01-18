import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../models/participant.dart';

class ScoringButtons extends StatelessWidget {
  final String eventId;
  final String refereeId;
  final List<Participant> participants;

  const ScoringButtons({
    super.key,
    required this.eventId,
    required this.refereeId,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: participants.map((participant) {
        final isRed = participant.corner == 'red';
        final color = isRed ? AppColors.redCorner : AppColors.blueCorner;

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScoreButton(
                  label: 'Punch (+1)',
                  color: color,
                  onPressed: () => _updateScore(participant.id, 'punch', 1),
                ),
                const SizedBox(height: 16),
                _buildScoreButton(
                  label: 'Kick (+2)',
                  color: color,
                  onPressed: () => _updateScore(participant.id, 'kick', 2),
                ),
                const SizedBox(height: 16),
                _buildScoreButton(
                  label: 'Knee (+3)',
                  color: color,
                  onPressed: () => _updateScore(participant.id, 'knee', 3),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScoreButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // primary: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _updateScore(String participantId, String moveType, int points) {
    // TODO: Implement score update via WebSocket
    print('Update score: $participantId, $moveType, $points');
  }
}
