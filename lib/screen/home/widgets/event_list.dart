import 'package:flutter/material.dart';
import '../../../models/event.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  final String title;
  final List<Event> events;
  final bool isActive;

  const EventList({super.key, 
    required this.title,
    required this.events,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            // style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (context, index) => EventCard(event: events[index]),
        ),
      ],
    );
  }
}