import 'package:flutter/material.dart';
import '../../../config/constants/colors.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCornerScore('Red Corner', AppColors.redCorner),
          _buildVsLabel(),
          _buildCornerScore('Blue Corner', AppColors.blueCorner),
        ],
      ),
    );
  }

  Widget _buildCornerScore(String corner, Color color) {
    return Column(
      children: [
        Text(corner),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Text('Punches: 0'),
              Text('Kicks: 0'),
              Text('Knees: 0'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVsLabel() {
    return const Text(
      'VS',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}