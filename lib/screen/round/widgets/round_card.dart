// lib/screens/round_screen/widgets/round_card.dart
import 'package:flutter/material.dart';

import '../../../models/competetion_model.dart';

class RoundCard extends StatelessWidget {
  final RoundsDetail? roundDetail;
  final int roundNumber;

  const RoundCard({
    super.key,
    required this.roundDetail,
    required this.roundNumber,
  });

  String _getStatusText(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'In Progress';
      case 2:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Round $roundNumber',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(roundDetail?.status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getStatusText(roundDetail?.status),
                style: TextStyle(
                  color: _getStatusColor(roundDetail?.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        subtitle: roundDetail!.history.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('History:'),
                  ...roundDetail!.history.map((event) => Text('• $event')),
                ],
              )
            : null,
      ),
    );
  }
}
