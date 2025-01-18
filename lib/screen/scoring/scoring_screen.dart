import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/scoring/scoring_bloc.dart';
import 'widgets/main_jury_controls.dart';
import 'widgets/score_board.dart';
import 'widgets/scoring_controls.dart';

class ScoringScreen extends StatelessWidget {
  final String eventId;
  final bool isReferee;
  final bool isMainJury;

  const ScoringScreen({
    super.key,
    required this.eventId,
    this.isReferee = false,
    this.isMainJury = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoringBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Match Scoring'),
        ),
        body: Column(
          children: [
            ScoreBoard(),
            if (isReferee) ScoringControls(),
            if (isMainJury) const MainJuryControls(),
          ],
        ),
      ),
    );
  }
}
