import '../../../models/score.dart';

abstract class ScoringState {}

class ScoringInitial extends ScoringState {}

class ScoringConnected extends ScoringState {
  final Map<String, Score> scores;

  ScoringConnected(this.scores);
}

class ScoringError extends ScoringState {
  final String message;

  ScoringError(this.message);
}
