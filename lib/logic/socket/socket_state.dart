part of 'socket_bloc.dart';

@immutable
abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketMessage extends SocketState {
  final String message;

  SocketMessage({required this.message});
}

class SocketError extends SocketState {
  final String message;

  SocketError({required this.message});
}

class SocketDisconnectedState extends SocketState {}
