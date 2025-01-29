import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/connection/connection_bloc.dart';
import 'package:my_app/screen/round/widgets/animated_markup_list.dart';

import '../../config/shared_prefs_config.dart';
import '../../logic/connection/connection_bloc.dart' as ct;
import '../../logic/match/match_bloc.dart';
import 'widgets/animated_referee_status_widget.dart';
import 'widgets/participant_status.dart';
import 'widgets/timer_display.dart';

class JuryRoundScreen extends StatefulWidget {
  const JuryRoundScreen(
      {super.key, required this.eventId, required this.position});
  final String eventId;
  final String position;

  @override
  State<JuryRoundScreen> createState() => _JuryRoundScreenState();
}

class _JuryRoundScreenState extends State<JuryRoundScreen> {
  late final ConnectionBloc _connectionBloc;

  @override
  void initState() {
    _connectionBloc = context.read<ConnectionBloc>();
    _connectionBloc.add(ConnectWebSocket(
      eventId: widget.eventId,
      position: widget.position,
    ));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _connectionBloc.add(DisconnectWebSocket());
    // TODO: implement dispose
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
        builder: (context, state) {
          return ListView(
            children: [
              const TimerDisplay(),
              BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                builder: (context, cState) {
                  return RefereeStatusWidget(model: cState.connectedUserModel);
                },
              ),

              const ParticipantStatus(),
              // const ScoreBoard(),
              const Spacer(),
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
                            position: widget.position));
                      },
                      child: const Text('Start Match'),
                    ),
                    if (state.isActive && !state.isPaused)
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MatchBloc>().add(PauseMatch()),
                        child: const Text('Pause'),
                      ),
                    if (state.isPaused)
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MatchBloc>().add(StartMatch()),
                        child: const Text('Resume'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        // context.read<ct.ConnectionBloc>().add(StartTimer(
                        //     role: SharedPrefsConfig.getString(
                        //         SharedPrefsConfig.keyUserRole),
                        //     position: widget.position));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Stop Match'),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                builder: (context, cState) {
                  return cState.markUpModel == null
                      ? Center(
                          child: Text("NO mark Availble"),
                        )
                      : Container(
                          height: 500,
                          color: Colors.red,
                          child:
                              AnimatedMarkupList(newItem: cState.markUpModel));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
