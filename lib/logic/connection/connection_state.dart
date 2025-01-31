part of 'connection_bloc.dart';

enum ConnectionStatus {
  initial,
  connecting,
  connected,
  disconnected,
  error,
}

class ConnectionInitial extends ConnectionState {
  ConnectionInitial()
      : super(
            status: ConnectionStatus.initial,
            isStartTimer: false,
            isPauseTimer: false);
}

class ConnectionState {
  final ConnectedUserModel? connectedUserModel;
  final MarkUpModel? markUpModel;
  final SessionModel? sessionModel;
  final ConnectionStatus status;
  final WebSocketChannel? channel;
  final String? errorMessage;
  final String? infoMessage;

  final bool isStartTimer;
  final bool isPauseTimer;

  ConnectionState(
      {required this.status,
      required this.isStartTimer,
      required this.isPauseTimer,
      this.sessionModel,
      this.markUpModel,
      this.connectedUserModel,
      this.channel,
      this.errorMessage,
      this.infoMessage});
}
