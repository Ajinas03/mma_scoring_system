import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/round/round_widgets/score_section.dart';
import 'package:my_app/screen/round/round_widgets/timer_widget.dart';

import '../../logic/socket/socket_bloc.dart';
import '../../models/login_model.dart';

class RoundDetailsScreen extends StatelessWidget {
  final LoginModel? loginModel;
  const RoundDetailsScreen({super.key, required this.loginModel});
  final String socketUrl = "wss://qatwigoai.exomemed.com/ws/events";

  // "ws://10.0.2.2:8000/room/ws";
  @override
  Widget build(BuildContext context) {
    final socketBloc = BlocProvider.of<SocketBloc>(context);

    return Scaffold(
      appBar: secondaryAppBar(title: "Event Name  ${loginModel?.username}  "),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.rocket_rounded),
          onPressed: () {
            socketBloc.add(ConnectSocket(url: socketUrl));
          }),
      body: Column(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: "Score",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: "10",
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const TimerWidget(),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 1"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 2"),
                  ),
                )
              ],
            ),
          ),
          const Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ScoreSection(
                    hero: "sd",
                    bgColor: Colors.red,
                  ),
                ),
                Expanded(
                  child: ScoreSection(
                    hero: "hg",
                    bgColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SocketBloc, SocketState>(
              builder: (context, state) {
                if (state is SocketConnected) {
                  return const TextWidget(
                    textAlign: TextAlign.center,
                    text: "Connected to WebSocket",
                    fontSize: 30,
                  );
                } else if (state is SocketMessage) {
                  return TextWidget(
                    textAlign: TextAlign.center,
                    text: "Message: ${state.message}",
                    fontSize: 30,
                  );
                } else if (state is SocketError) {
                  return TextWidget(
                    textAlign: TextAlign.center,
                    text: "Error: ${state.message}",
                    fontSize: 30,
                  );
                } else if (state is SocketDisconnectedState) {
                  return const TextWidget(
                    textAlign: TextAlign.center,
                    text: "Disconnected from WebSocket",
                    fontSize: 30,
                  );
                }
                return const TextWidget(
                  textAlign: TextAlign.center,
                  text: "Waiting for action...",
                  fontSize: 30,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
