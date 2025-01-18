abstract class ScoringEvent {}

class UpdateScore extends ScoringEvent {
  final String participantId;
  final String scoreType;
  final int value;

  UpdateScore({
    required this.participantId,
    required this.scoreType,
    required this.value,
  });
}

class ConnectToMatch extends ScoringEvent {
  final String matchId;
  ConnectToMatch(this.matchId);
}

class DisconnectFromMatch extends ScoringEvent {}