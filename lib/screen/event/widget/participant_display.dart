// lib/features/participants/widgets/participant_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/event/event_bloc.dart';
import 'package:my_app/models/get_participants_model.dart';

class ParticipantDisplay extends StatelessWidget {
  final String eventId;

  const ParticipantDisplay({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final participants = state.getParicipantsModel;
        if (participants == null) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
                'Players', participants.players, Icons.sports_handball),
            if (participants.players.isNotEmpty) const SizedBox(height: 16),
            _buildSection('Jury', participants.jury, Icons.gavel),
            if (participants.jury.isNotEmpty) const SizedBox(height: 16),
            _buildSection('Referees', participants.referees, Icons.sports),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, List<Jury> participants, IconData icon) {
    if (participants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                participants.length.toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildParticipantList(participants),
      ],
    );
  }

  Widget _buildParticipantList(List<Jury> participants) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: participants.length,
      itemBuilder: (context, index) {
        final participant = participants[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            title: Text(
              '${participant.fname} ${participant.lname}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${participant.city}, ${participant.state}, ${participant.country}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                if (participant.weight > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.fitness_center, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${participant.weight} kg',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  participant.gender.toLowerCase() == 'male'
                      ? Icons.male
                      : participant.gender.toLowerCase() == 'female'
                          ? Icons.female
                          : Icons.person,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
