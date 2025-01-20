import 'package:flutter/material.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/screen/add_data/create_participants_screen.dart.dart';

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
            ProfileListTileButton(
                leadingIcon: Icons.group_add_outlined,
                title: "Add Players",
                onTap: () {
                  pushScreen(
                      context,
                      CreateParticipantScreen(
                        role: 'player',
                        eventId: eventDetails?.eventId ?? "",
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.group_add_outlined,
                title: "Add Jury",
                onTap: () {
                  pushScreen(
                      context,
                      CreateParticipantScreen(
                        eventId: eventDetails?.eventId ?? "",
                        role: 'jury',
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.group_add_outlined,
                title: "Add Referee",
                onTap: () {
                  pushScreen(
                      context,
                      CreateParticipantScreen(
                        eventId: eventDetails?.eventId ?? "",
                        role: 'referee',
                      ));
                }),
            ProfileListTileButton(
                leadingIcon: Icons.wine_bar,
                title: "Coompetetion",
                onTap: () {}),
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
          ],
        ),
      ),
    );
  }
}
