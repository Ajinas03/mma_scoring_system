import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/connection/connection_bloc.dart';
import 'package:my_app/screen/round/widgets/animated_markup_list.dart';

import '../../config/shared_prefs_config.dart';
import '../../logic/connection/connection_bloc.dart' as ct;
import '../../logic/match/match_bloc.dart';
import 'widgets/animated_referee_status_widget.dart';

class JuryRoundScreen extends StatefulWidget {
  const JuryRoundScreen(
      {super.key, required this.competitionId, required this.position});
  final String competitionId;
  final String position;

  @override
  State<JuryRoundScreen> createState() => _JuryRoundScreenState();
}

class _JuryRoundScreenState extends State<JuryRoundScreen> {
  late final ConnectionBloc _connectionBloc;

  @override
  void initState() {
    super.initState();
    _connectionBloc = context.read<ConnectionBloc>();
    _connectionBloc.add(ConnectWebSocket(
      competitionId: widget.competitionId,
      position: widget.position,
    ));
  }

  @override
  void dispose() {
    _connectionBloc.add(DisconnectWebSocket());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jury Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to history screen
            },
          ),
        ],
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, matchState) {
          return Column(
            children: [
              // const TimerDisplay(),
              BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                builder: (context, cState) {
                  return RefereeStatusWidget(model: cState.connectedUserModel);
                },
              ),
              // const ParticipantStatus(),

              BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                builder: (context, cState) {
                  return cState.markUpModel == null
                      ? Center(child: Text("NO mark Available"))
                      : Expanded(
                          child:
                              AnimatedMarkupList(newItem: cState.markUpModel),
                        );
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<ct.ConnectionBloc>().add(StartTimer(
                              role: SharedPrefsConfig.getString(
                                  SharedPrefsConfig.keyUserRole),
                              position: widget.position,
                            ));
                      },
                      child: const Text('Start Match'),
                    ),
                    if (matchState.isActive && !matchState.isPaused)
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MatchBloc>().add(PauseMatch()),
                        child: const Text('Pause'),
                      ),
                    if (matchState.isPaused)
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MatchBloc>().add(StartMatch()),
                        child: const Text('Resume'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle stop match logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Stop Match'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
