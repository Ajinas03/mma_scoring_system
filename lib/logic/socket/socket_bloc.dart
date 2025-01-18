import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  WebSocketChannel? _channel;

  SocketBloc() : super(SocketInitial()) {
    on<ConnectSocket>((event, emit) {
      try {
        print('Connecting to WebSocket URL: ${event.url}');
        _channel = WebSocketChannel.connect(Uri.parse(event.url));
        emit(SocketConnected());
        print('Successfully connected to WebSocket');

        _channel!.stream.listen(
          (message) {
            add(SocketMessageReceived(message: message));
          },
          onError: (error) {
            print('WebSocket error: $error');
            add(SocketErrorOccurred(error: error.toString()));
          },
          onDone: () {
            print('WebSocket connection closed');
            add(SocketDisconnected());
          },
        );
      } catch (e) {
        print('Error connecting to WebSocket: $e');
        emit(SocketError(message: "Connection failed: ${e.toString()}"));
      }
    });

    on<SendMessage>((event, emit) {
      if (_channel != null) {
        final userData = {
          "username": "Ajinas", // Example username
          "role": "jury", // Example role
          "userid": "ajnas_admin", // Example userid
          "event": "fifa", // Example event
          "message": event.message
        };

        // Sending the user_data to the WebSocket server
        _channel!.sink.add(jsonEncode(userData));
        print("${userData['username']} connected");

        // _channel!.sink.add(
        //   event.message);
      } else {
        print("xxxxxxxxxxxxxxxx not connected socket  xxxxxxxxxxx");
        emit(SocketError(message: "Socket not connected"));
      }
    });

    on<SocketMessageReceived>((event, emit) {
      emit(SocketMessage(message: event.message));
    });

    on<SocketDisconnected>((event, emit) {
      _channel?.sink.close();
      emit(SocketDisconnectedState());
    });
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}
