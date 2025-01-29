part of 'match_bloc.dart';

class MatchInitial extends MatchState {
  MatchInitial()
      : super(
          isActive: false,
          isPaused: false,
          timeRemaining: 180,
          playerOneScores: const {},
          playerTwoScores: const {},
          connectedReferees: const [],
          isJuryConnected: false,
        );
}

class MatchState {
  final bool isActive;
  final bool isPaused;
  final int timeRemaining;
  final Map<String, int> playerOneScores;
  final Map<String, int> playerTwoScores;
  final List<String> connectedReferees;
  final bool isJuryConnected;

  MatchState({
    required this.isActive,
    required this.isPaused,
    required this.timeRemaining,
    required this.playerOneScores,
    required this.playerTwoScores,
    required this.connectedReferees,
    required this.isJuryConnected,
  });
}