import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/event/widget/player_list_widget.dart';

import '../../config/screen_config.dart';
import '../../logic/event/event_bloc.dart';
import '../add_data/create_participants_screen.dart.dart';
import '../common/app_bar_widgets.dart';

class JuryScreen extends StatelessWidget {
  final String eventId;
  const JuryScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    context.read<EventBloc>().add(GetEventParticipants(eventId: eventId));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushScreen(
              context,
              CreateParticipantScreen(
                eventId: eventId,
                role: 'jury',
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: secondaryAppBar(title: "Jury"),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final participants = state.getParicipantsModel;
          if (participants == null) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerListWidget(
                  participants: participants.jury ?? [],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
