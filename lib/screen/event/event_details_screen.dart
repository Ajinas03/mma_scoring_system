import 'package:flutter/material.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/screen/competetion/competetion_screen.dart';
import 'package:my_app/screen/event/jury_screen.dart';
import 'package:my_app/screen/event/players_screen.dart';
import 'package:my_app/screen/event/referee_screen.dart';

import '../../models/event_resp_model.dart';
import '../profile/profile_widget/profile_button.dart';
import 'widget/event_header.dart';
import 'widget/event_info.dart';
import 'widget/location_info.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventRespModel? eventDetails;

  const EventDetailsScreen({
    super.key,
    required this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    final eventId = eventDetails?.eventId ?? "";

    print("event id ===========  ${eventDetails?.eventId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventHeader(
              eventName: eventDetails?.name ?? '',
              eventCategory: eventDetails?.category ?? '',
            ),
            EventInfoCard(
              eventId: eventDetails?.eventId ?? '',
              eventDate: eventDetails?.date.toString() ?? '',
            ),
            LocationInfoCard(
              address: eventDetails?.address ?? '',
              state: eventDetails?.state ?? '',
              country: eventDetails?.category ?? '',
              zipcode: eventDetails?.zipcode ?? '',
            ),
            ProfileListTileButton(
                leadingIcon: Icons.group_outlined,
                title: "Players",
                onTap: () {
                  pushScreen(
                      context,
                      PlayersScreen(
                        eventId: eventId,
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.group_outlined,
                title: "Jury",
                onTap: () {
                  pushScreen(
                      context,
                      JuryScreen(
                        eventId: eventId,
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.group_outlined,
                title: "Referee",
                onTap: () {
                  pushScreen(
                      context,
                      RefereeScreen(
                        eventId: eventId,
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.wine_bar,
                title: "Competetion",
                onTap: () {
                  pushScreen(context, CompetetionScreen());
                }),
          ],
        ),
      ),
    );
  }
}
