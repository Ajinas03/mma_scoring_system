part of 'connection_bloc.dart';

@immutable
abstract class ConnectionEvent {}

class ConnectWebSocket extends ConnectionEvent {
  final String eventId;
  final String position;
  ConnectWebSocket({
    required this.eventId,
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

class MarkScore extends ConnectionEvent {
  final String role;
  final String position;
  final String mark;
  MarkScore({
    required this.role,
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
