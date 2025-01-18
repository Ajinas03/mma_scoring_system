import 'package:flutter/material.dart';

class MainJuryControls extends StatelessWidget {
  const MainJuryControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRefereeScores(),
        _buildFinalScoreControls(),
      ],
    );
  }

  Widget _buildRefereeScores() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Referee Scores',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildRefereeScoreTable(),
        ],
      ),
    );
  }

  Widget _buildRefereeScoreTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Referee')),
          DataColumn(label: Text('Corner')),
          DataColumn(label: Text('Punches')),
          DataColumn(label: Text('Kicks')),
          DataColumn(label: Text('Knees')),
          DataColumn(label: Text('Total')),
        ],
        rows: const [], // TODO: Populate with actual referee scores
      ),
    );
  }

  Widget _buildFinalScoreControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Final Decision',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // primary: AppColors.redCorner,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Red Corner Wins'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Draw'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // primary: AppColors.blueCorner,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Blue Corner Wins'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
