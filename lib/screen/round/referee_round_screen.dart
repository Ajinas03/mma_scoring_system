import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/round/widgets/animated_markup_list.dart';
import 'package:my_app/screen/round/widgets/animated_referee_status_widget.dart';
import 'package:my_app/screen/round/widgets/split_game_control.dart';

import '../../logic/connection/connection_bloc.dart' as ct;

class RefereeRoundScreen extends StatelessWidget {
  final String refereeId;
  final String competitionId;
  final String position;
  final int round;

  const RefereeRoundScreen({
    super.key,
    required this.refereeId,
    required this.round,
    required this.competitionId,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize WebSocket connection
    context.read<ct.ConnectionBloc>().add(
          ct.ConnectWebSocket(
            round: round,
            competitionId: competitionId,
            position: position,
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Referee Panel'),
      ),
      body: BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Referee Status
                RefereeStatusWidget(model: state.connectedUserModel),

                // Markup List
                state.markUpModel == null
                    ? const Expanded(
                        flex: 3,
                        child: Center(child: Text("NO mark Available")))
                    : Expanded(
                        flex: 3,
                        child: AnimatedMarkupList(
                          newItem: state.markUpModel,
                          competitionId: competitionId,
                          round: round,
                        ),
                      ),

                // Game Controls
                state.sessionModel?.duration == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: "Game is Not Availalbe Now \nPls Wait",
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          fontSize: 24,
                        ),
                      )
                    : Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: GameBoyStyleControls(
                            onBlueLeftPressed: () =>
                                _handleScore(context, false, "-1"),
                            onBlueRightPressed: () =>
                                _handleScore(context, false, "1"),
                            onRedLeftPressed: () =>
                                _handleScore(context, true, "1"),
                            onRedRightPressed: () =>
                                _handleScore(context, true, "-1"),
                            buttonSize: 75,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleScore(BuildContext context, bool ismarkedToRed, String mark) {
    context.read<ct.ConnectionBloc>().add(
          ct.MarkScore(
            role: SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole),
            ismarkedToRed: ismarkedToRed,
            mark: mark,
            position: position,
          ),
        );
    print('${ismarkedToRed ? "Red" : "Blue"} button pressed with mark: $mark');
  }
}
