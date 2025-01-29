import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/connection/connection_bloc.dart' as ct;

import '../../../logic/match/match_bloc.dart';

class ScoreControls extends StatelessWidget {
  final String playerId;
  final String playerName;
  final String refereeId;
  final String position;
  const ScoreControls({
    super.key,
    required this.position,
    required this.playerId,
    required this.playerName,
    required this.refereeId,
  });

  @override
  Widget build(BuildContext context) {
    int mark = 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    mark--;

                    // context.read<MatchBloc>().add(
                    //     UpdateScore(
                    //       playerId: playerId,
                    //       points: -1,
                    //       refereeId: refereeId,
                    //     ),
                    //   );

                    context.read<ct.ConnectionBloc>().add(ct.MarkScore(
                        role: SharedPrefsConfig.getString(
                            SharedPrefsConfig.keyUserRole),
                        mark: mark.toString(),
                        position: position));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Icon(Icons.remove),
                ),
                BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    final scores = playerId == 'player_one'
                        ? state.playerOneScores
                        : state.playerTwoScores;
                    return BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                      builder: (context, cState) {
                        return Text(
                          cState.markUpModel?.marked ?? "N/A",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    mark++;
                    context.read<ct.ConnectionBloc>().add(ct.MarkScore(
                        role: SharedPrefsConfig.getString(
                            SharedPrefsConfig.keyUserRole),
                        mark: mark.toString(),
                        position: position));

                    // context.read<MatchBloc>().add(
                    //       UpdateScore(
                    //         playerId: playerId,
                    //         points: 1,
                    //         refereeId: refereeId,
                    //       ),
                    //     );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
