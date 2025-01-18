part of 'socket_bloc.dart';

@immutable
abstract class SocketEvent {}

class ConnectSocket extends SocketEvent {
  final String url;

  ConnectSocket({required this.url});
}

class SendMessage extends SocketEvent {
  final String message;

  SendMessage({required this.message});
}

class SocketMessageReceived extends SocketEvent {
  final String message;

  SocketMessageReceived({required this.message});
}

class SocketDisconnected extends SocketEvent {}

class SocketErrorOccurred extends SocketEvent {
  final String error;

  SocketErrorOccurred({required this.error});
}
