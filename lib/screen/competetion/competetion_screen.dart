import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/competetion/create_competetion_screen.dart';
import 'package:my_app/screen/round/round_screen.dart';

import '../../logic/event/event_bloc.dart';
import 'competetion_widgets/competition_card.dart';

class CompetetionScreen extends StatelessWidget {
  final String eventId;
  const CompetetionScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    context.read<EventBloc>().add(GetCompetetion(eventId: eventId));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushReplaceScreen(context, CreateCompetitionScreen());
        },
        child: Icon(Icons.add),
      ),
      appBar: secondaryAppBar(title: "Competetions"),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          final competitions = state.competetionModel;
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (competitions?.isEmpty ?? true)
                  ? Center(
                      child: Text("Empty"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: competitions?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            pushScreen(context,
                                RoundScreen(competition: competitions?[index]));
                          },
                          child: CompetitionCard(
                              competition: competitions?[index]),
                        );
                      },
                    );
        },
      ),
    );
  }
}
