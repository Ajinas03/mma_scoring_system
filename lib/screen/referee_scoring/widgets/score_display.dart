import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../models/participant.dart';

class ScoreDisplay extends StatelessWidget {
  final List<Participant> participants;

  const ScoreDisplay({
    super.key,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: participants.map((participant) {
          final isRed = participant.corner == 'red';
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isRed ? AppColors.redCorner : AppColors.blueCorner,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  participant.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Total: 0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
