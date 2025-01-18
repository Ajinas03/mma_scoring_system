import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../models/event.dart';
import '../../../models/participant.dart';
import '../../../utils/dummy_data.dart';
import '../../main_jury/main_jury_screen.dart';
import '../../referee_scoring/referee_scoring_screen.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => event.isActive ? _showRoleSelectionDialog(context) : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${event.date.day}/${event.date.month}/${event.date.year}',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildParticipantInfo(event.participants[0], true),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('VS'),
                  ),
                  _buildParticipantInfo(event.participants[1], false),
                ],
              ),
              const SizedBox(height: 8),
              _buildStatusChip(event.isActive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantInfo(Participant participant, bool isRed) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isRed
              ? AppColors.redCorner.withOpacity(0.1)
              : AppColors.blueCorner.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          participant.name,
          style: TextStyle(
            color: isRed ? AppColors.redCorner : AppColors.blueCorner,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'Active' : 'Completed',
        style: TextStyle(
          color: isActive ? Colors.green : Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showRoleSelectionDialog(BuildContext context) {
    final referees = DummyData.getReferees();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Role'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: referees.map((referee) {
            return ListTile(
              title: Text(referee['name']),
              subtitle: Text(referee['position']),
              onTap: () {
                Navigator.pop(context);
                if (referee['isMainJury']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainJuryScreen(
                        eventId: event.id,
                        participants: event.participants,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RefereeScoreScreen(
                        eventId: event.id,
                        refereeId: referee['id'],
                        participants: event.participants,
                      ),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
