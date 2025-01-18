import 'package:flutter/material.dart';
import '../../../config/constants/colors.dart';

class ScoringControls extends StatelessWidget {
  const ScoringControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildScoringColumn('Red Corner', AppColors.redCorner),
          _buildScoringColumn('Blue Corner', AppColors.blueCorner),
        ],
      ),
    );
  }

  Widget _buildScoringColumn(String corner, Color color) {
    return Column(
      children: [
        Text(corner),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            
            
            // primary: color
            
            ),
          child: Text('Punch'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            
            
            // primary: color
            
            )
            ,
          child: Text('Kick'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            
            // primary: color
            
            ),
          child: Text('Knee'),
        ),
      ],
    );
  }
}