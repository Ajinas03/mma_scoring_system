import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/connection/connection_bloc.dart';
import 'package:my_app/repo/event_repo.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/round/widgets/animated_markup_list.dart';
import 'package:my_app/utils/competetion_utils.dart';

import '../../config/shared_prefs_config.dart';
import '../../logic/connection/connection_bloc.dart' as ct;
import '../../logic/event/event_bloc.dart';
import 'widgets/animated_referee_status_widget.dart';

class JuryRoundScreen extends StatefulWidget {
  const JuryRoundScreen(
      {super.key,
      required this.competitionId,
      required this.position,
      required this.eventId,
      required this.round});
  final String competitionId;
  final String position;
  final String eventId;
  final int round;

  @override
  State<JuryRoundScreen> createState() => _JuryRoundScreenState();
}

class _JuryRoundScreenState extends State<JuryRoundScreen> {
  late final ConnectionBloc _connectionBloc;
  Future<bool> _onWillPop() async {
    // Get the current state before popping

    // You can dispatch an event to your bloc here if needed
    // For example, to clear or update certain data
    context.read<EventBloc>().add(GetCompetetion(eventId: widget.eventId));

    // You can also save any data to SharedPrefs if needed
    // await SharedPrefsConfig.setString('last_viewed_round', someValue);

    // Show a confirmation dialog if needed
    // final shouldPop = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Are you sure?'),
    //     content: Text('Do you want to leave this page?'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: Text('No'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, true),
    //         child: Text('Yes'),
    //       ),
    //     ],
    //   ),
    // ) ?? false;
    // return shouldPop;

    // Return true to allow pop, false to prevent pop
    return true;
  }

  @override
  void initState() {
    print("competition id = ${widget.competitionId}");
    super.initState();
    _connectionBloc = context.read<ConnectionBloc>();
    _connectionBloc.add(ConnectWebSocket(
      competitionId: widget.competitionId,
      round: widget.round,
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                      ? Expanded(
                          child: Center(child: Text("NO mark Available")))
                      : Expanded(
                          child: Container(
                              child: AnimatedMarkupList(
                                  eventId: widget.eventId,
                                  round: widget.round,
                                  competitionId: widget.competitionId,
                                  newItem: cState.markUpModel)),
                        );
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
                  builder: (context, state) {
                    final user = state.connectedUserModel?.details;

                    return !areAnyTwoConnected(
                            mainJury: user?.mainJury,
                            cornerAReferee: user?.cornerAReferee,
                            cornerBReferee: user?.cornerBReferee,
                            cornerCReferee: user?.cornerCReferee)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextWidget(
                              text: "Waiting for one more referee to connect",
                              fontSize: 18,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Control buttons (Start, Pause, Resume) in same position
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Show Start button only if timer hasn't started
                                  if (!state.isStartTimer)
                                    ElevatedButton(
                                      onPressed: () {
                                        // event in progress
                                        EventRepo.updateRoundStatus(
                                            context: context,
                                            competitionId: widget.competitionId,
                                            round: widget.round,
                                            status: 1);

                                        context.read<ct.ConnectionBloc>().add(
                                              StartTimer(
                                                role:
                                                    SharedPrefsConfig.getString(
                                                        SharedPrefsConfig
                                                            .keyUserRole),
                                                position: widget.position,
                                              ),
                                            );
                                      },
                                      child: const Text('Start Match'),
                                    ),
                                  // Show Pause button only if timer is running and not paused
                                  if (state.isStartTimer && !state.isPauseTimer)
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ct.ConnectionBloc>().add(
                                              PauseTimer(
                                                role:
                                                    SharedPrefsConfig.getString(
                                                        SharedPrefsConfig
                                                            .keyUserRole),
                                                position: widget.position,
                                              ),
                                            );
                                      },
                                      child: const Text('Pause'),
                                    ),
                                  // Show Resume button only if the timer is paused
                                  if (state.isStartTimer && state.isPauseTimer)
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ct.ConnectionBloc>().add(
                                              ResumeTimer(
                                                role:
                                                    SharedPrefsConfig.getString(
                                                        SharedPrefsConfig
                                                            .keyUserRole),
                                                position: widget.position,
                                              ),
                                            );
                                      },
                                      child: const Text('Resume'),
                                    ),
                                ],
                              ),
                              // Stop Match button at the bottom
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ct.ConnectionBloc>().add(
                                        StopTimer(
                                          role: SharedPrefsConfig.getString(
                                              SharedPrefsConfig.keyUserRole),
                                          position: widget.position,
                                        ),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Stop Match'),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
