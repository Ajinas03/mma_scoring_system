import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/round/widgets/animated_referee_status_widget.dart';

import '../../logic/connection/connection_bloc.dart' as ct;
import 'widgets/score_controls.dart';
import 'widgets/timer_display.dart';

class RefereeRoundScreen extends StatelessWidget {
  final String refereeId;
  final String competitionId;
  final String position;
  const RefereeRoundScreen(
      {super.key,
      required this.refereeId,
      required this.competitionId,
      required this.position});

  @override
  Widget build(BuildContext context) {
    context.read<ct.ConnectionBloc>().add(
          ct.ConnectWebSocket(
            competitionId: competitionId,
            position: position,
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text('Referee Panel - $refereeId'),
      ),
      body: ListView(
        children: [
          const TimerDisplay(),
          const SizedBox(height: 20),
          // if (state.isActive && !state.isPaused) ...[
          ScoreControls(
            position: position,
            playerId: 'player_one',
            playerName: 'Red Corner',
            refereeId: refereeId,
          ),
          const SizedBox(height: 20),
          ScoreControls(
            position: position,
            playerId: 'player_two',
            playerName: 'Blue Corner',
            refereeId: refereeId,
          ),
          // ] else
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                builder: (context, state) {
                  return   
                  
                  
                   RefereeStatusWidget(model: state.connectedUserModel);
                },
              ),
              const Center(
                child: Text(
                  'Waiting for match to start...',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
