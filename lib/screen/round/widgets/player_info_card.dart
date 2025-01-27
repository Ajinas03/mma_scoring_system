// lib/screens/round_screen/widgets/player_info_card.dart
import 'package:flutter/material.dart';

import '../../../models/competetion_model.dart';

class PlayerInfoCard extends StatelessWidget {
  final CornerAReferee? player;
  final Color cornerColor;
  final bool isRedCorner;

  const PlayerInfoCard({
    super.key,
    required this.player,
    required this.cornerColor,
    required this.isRedCorner,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: cornerColor.withOpacity(0.2),
              radius: 30,
              child: Text(
                player?.name[0].toUpperCase() ?? "",
                style: TextStyle(
                  color: cornerColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              player?.name ?? "",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              isRedCorner ? 'Red Corner' : 'Blue Corner',
              style: TextStyle(
                color: cornerColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
