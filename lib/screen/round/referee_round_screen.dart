import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/round/widgets/animated_markup_list.dart';
import 'package:my_app/screen/round/widgets/animated_referee_status_widget.dart';
import 'package:my_app/screen/round/widgets/split_game_control.dart';

import '../../logic/connection/connection_bloc.dart' as ct;

class RefereeRoundScreen extends StatefulWidget {
  final String refereeId;
  final String competitionId;
  final String position;
  final int round;
  final String eventId;
  const RefereeRoundScreen({
    super.key,
    required this.refereeId,
    required this.eventId,
    required this.round,
    required this.competitionId,
    required this.position,
  });

  @override
  State<RefereeRoundScreen> createState() => _RefereeRoundScreenState();
}

class _RefereeRoundScreenState extends State<RefereeRoundScreen> {
  Future<bool> _onWillPop() async {
    // Perform any cleanup or state updates

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
    // Initialize WebSocket connection
    context.read<ct.ConnectionBloc>().add(
          ct.ConnectWebSocket(
            round: widget.round,
            competitionId: widget.competitionId,
            position: widget.position,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                            eventId: widget.eventId,
                            newItem: state.markUpModel,
                            competitionId: widget.competitionId,
                            round: widget.round,
                          ),
                        ),

                  // Game Controls

                  state.connectedUserModel?.sessionActive == false
                      // state.sessionModel?.duration == 0
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
      ),
    );
  }

  void _handleScore(BuildContext context, bool ismarkedToRed, String mark) {
    context.read<ct.ConnectionBloc>().add(
          ct.MarkScore(
            role: SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole),
            ismarkedToRed: ismarkedToRed,
            mark: mark,
            position: widget.position,
          ),
        );
    print('${ismarkedToRed ? "Red" : "Blue"} button pressed with mark: $mark');
  }
}
