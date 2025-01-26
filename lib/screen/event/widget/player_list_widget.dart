import 'package:flutter/material.dart';
import 'package:my_app/screen/common/text_widget.dart';

import '../../../models/get_participants_model.dart';

class PlayerListWidget extends StatelessWidget {
  final List<Jury> participants;
  const PlayerListWidget({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        _buildParticipantList(participants),
      ],
    );
  }
}

Widget _buildParticipantList(List<Jury> participants) {
  return participants.isEmpty
      ? Center(
          child: TextWidget(text: "Empty"),
        )
      : ListView.builder(
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
