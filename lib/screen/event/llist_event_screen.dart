import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/screen/add_data/create_event_screen.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/event/event_details_screen.dart';

import '../../logic/event/event_bloc.dart';
import '../add_data/widget/event_tile.dart';

class AddRoundScreen extends StatelessWidget {
  const AddRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EventBloc>().add(GetEvent());
    return Scaffold(
      appBar: primaryAppBar(title: "Events"),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            pushScreen(context, CreateRoundScreen());
          }),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          final items = state.events;
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : items.isEmpty
                  ? Center(
                      child: TextWidget(text: "EVENT IS EMPTY"),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return EventListTile(
                          event: items[index],
                          onTap: () {
                            pushScreen(
                                context,
                                EventDetailsScreen(
                                  eventDetails: items[index],
                                ));
                          },
                        );
                      });
        },
      ),
    );
  }
}
