// lib/screens/round_screen/widgets/referee_info_widget.dart
import 'package:flutter/material.dart';

import '../../../models/competetion_model.dart';

class RefereeInfoWidget extends StatelessWidget {
  final CornerAReferee? cornerAReferee;
  final CornerAReferee? cornerBReferee;
  final CornerAReferee? cornerCReferee;

  const RefereeInfoWidget({
    super.key,
    required this.cornerAReferee,
    required this.cornerBReferee,
    required this.cornerCReferee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Referees',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildRefereeRow('Corner A', cornerAReferee),
            _buildRefereeRow('Corner B', cornerBReferee),
            _buildRefereeRow('Corner C', cornerCReferee),
          ],
        ),
      ),
    );
  }

  Widget _buildRefereeRow(String title, CornerAReferee? referee) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(referee?.name ?? ""),
        ],
      ),
    );
  }
}
