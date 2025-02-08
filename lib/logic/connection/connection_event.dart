part of 'connection_bloc.dart';

@immutable
abstract class ConnectionEvent {}

class ConnectWebSocket extends ConnectionEvent {
  final String competitionId;
  final String position;
  final int round;
  ConnectWebSocket({
    required this.competitionId,
    required this.round,
    required this.position,
  });
}

class DisconnectWebSocket extends ConnectionEvent {}

class ReconnectWebSocket extends ConnectionEvent {}

class StartTimer extends ConnectionEvent {
  final String role;
  final String position;
  StartTimer({
    required this.role,
    required this.position,
  });
}

class PauseTimer extends ConnectionEvent {
  final String role;
  final String position;
  PauseTimer({
    required this.role,
    required this.position,
  });
}

class StopTimer extends ConnectionEvent {
  final String role;
  final String position;
  StopTimer({
    required this.role,
    required this.position,
  });
}

class ResumeTimer extends ConnectionEvent {
  final String role;
  final String position;
  ResumeTimer({
    required this.role,
    required this.position,
  });
}

class MarkScore extends ConnectionEvent {
  final String role;
  final String position;
  final String mark;
  final bool ismarkedToRed;
  MarkScore({
    required this.role,
    required this.ismarkedToRed,
    required this.mark,
    required this.position,
  });
}

class MessageReceived extends ConnectionEvent {
  final dynamic message;

  MessageReceived({
    required this.message,
  });
}
