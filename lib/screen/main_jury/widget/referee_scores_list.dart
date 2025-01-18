import 'package:flutter/material.dart';
import 'dart:async';
import '../../../models/participant.dart';
import '../../../config/constants/colors.dart';

class RefereeScoresList extends StatefulWidget {
  final String eventId;
  final List<Participant> participants;

  const RefereeScoresList({
    Key? key,
    required this.eventId,
    required this.participants,
  }) : super(key: key);

  @override
  _RefereeScoresListState createState() => _RefereeScoresListState();
}

class _RefereeScoresListState extends State<RefereeScoresList> {
  final List<Map<String, dynamic>> _scores = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadInitialScores();
    _startRealtimeUpdates();
  }

  void _loadInitialScores() {
    // Simulating initial data
    setState(() {
      _scores.addAll([
        {
          'id': '1',
          'refereeId': 'ref1',
          'refereeName': 'Robert Wilson',
          'participantId': '1',
          'moveType': 'punch',
          'points': 1,
          'timestamp': DateTime.now().subtract(const Duration(minutes: 1)),
        },
        {
          'id': '2',
          'refereeId': 'ref2',
          'refereeName': 'David Brown',
          'participantId': '2',
          'moveType': 'kick',
          'points': 2,
          'timestamp': DateTime.now().subtract(const Duration(minutes: 2)),
        },
      ]);
    });
  }

  void _startRealtimeUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Simulating real-time updates
      final newScore = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'refereeId': 'ref${(timer.tick % 3) + 1}',
        'refereeName': ['Robert Wilson', 'David Brown', 'James Davis'][timer.tick % 3],
        'participantId': (timer.tick % 2 + 1).toString(),
        'moveType': ['punch', 'kick', 'knee'][timer.tick % 3],
        'points': [1, 2, 3][timer.tick % 3],
        'timestamp': DateTime.now(),
      };

      setState(() {
        _scores.insert(0, newScore);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Live Score Updates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: AnimatedList(
            initialItemCount: _scores.length,
            itemBuilder: (context, index, animation) {
              final score = _scores[index];
              final participant = widget.participants.firstWhere(
                (p) => p.id == score['participantId'],
              );
              
              return SizeTransition(
                sizeFactor: animation,
                child: _buildScoreCard(score, participant),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(Map<String, dynamic> score, Participant participant) {
    final isRed = participant.corner == 'red';
    final color = isRed ? AppColors.redCorner : AppColors.blueCorner;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            score['points'].toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text('${score['refereeName']} scored ${score['moveType']}'),
        subtitle: Text('for ${participant.name}'),
        trailing: Text(
          '${score['timestamp'].hour}:${score['timestamp'].minute}:${score['timestamp'].second}',
        ),
      ),
    );
  }
}