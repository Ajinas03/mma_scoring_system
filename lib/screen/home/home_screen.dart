import 'package:flutter/material.dart';

import '../../utils/dummy_data.dart';
import 'widgets/event_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allEvents = DummyData.getEvents();
    final activeEvents = allEvents.where((event) => event.isActive).toList();
    final completedEvents =
        allEvents.where((event) => !event.isActive).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            EventList(
              title: 'Active Events',
              events: activeEvents,
              isActive: true,
            ),
            EventList(
              title: 'Completed Events',
              events: completedEvents,
              isActive: false,
            ),
          ],
        ),
      ),
      // floatingActionButton: const AddEventButton(),
    );
  }
}
