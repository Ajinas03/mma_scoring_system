part of 'match_bloc.dart';

@immutable
abstract class MatchEvent {}

class StartMatch extends MatchEvent {}

class PauseMatch extends MatchEvent {}

class StopMatch extends MatchEvent {}

class UpdateTimer extends MatchEvent {}

class UpdateScore extends MatchEvent {
  final String playerId;
  final int points;
  final String refereeId;

  UpdateScore({
    required this.playerId,
    required this.points,
    required this.refereeId,
  });
}
