import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/models/connected_user_model.dart';
import 'package:my_app/models/mark_up_model.dart';
import 'package:my_app/models/session_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  ConnectedUserModel? connectedUserModel;
  MarkUpModel? markUpModel;
  SessionModel? sessionModel;
  String infoMessage = "no message revcieved yet";
  String eventId = '';
  String position = '';
  StreamSubscription? _connectivitySubscription;
  StreamSubscription? _wsSubscription;

  ConnectionBloc() : super(ConnectionInitial()) {
    print('🚀 Initializing ConnectionBloc');

    on<ConnectWebSocket>(_onConnect);
    on<DisconnectWebSocket>(_onDisconnect);
    on<ReconnectWebSocket>(_onReconnect);
    on<MessageReceived>(_onMessageReceived);
    on<StartTimer>(_onStartTimer);
    on<MarkScore>(_onMarkScore);

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      print('📡 Connectivity changed: $result');
      if (result != ConnectivityResult.none) {
        add(ReconnectWebSocket());
      }
    });
  }

  void _onConnect(ConnectWebSocket event, Emitter<ConnectionState> emit) async {
    try {
      print('🔌 Connecting to WebSocket');
      await _wsSubscription?.cancel();
      emit(ConnectionState(
          markUpModel: state.markUpModel,
          sessionModel: state.sessionModel,
          status: ConnectionStatus.connecting,
          connectedUserModel: state.connectedUserModel));

      final wsUrl =
          'wss://masternode-856921708890.asia-south1.run.app/ws/v1.0/livePool';
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      eventId = event.eventId;

      position = event.position;
      final userRole =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole);

      final connectionMessage = jsonEncode({
        "username": userRole,
        "role": userRole,
        "event": event.eventId,
        "position": position
      });
      _channel?.sink.add(connectionMessage);
      print("connection payload xxxxxxxxxxx $connectionMessage");
      emit(ConnectionState(
          markUpModel: state.markUpModel,
          sessionModel: state.sessionModel,
          connectedUserModel: state.connectedUserModel,
          status: ConnectionStatus.connected,
          channel: _channel));
      print('✅ WebSocket connected successfully');

      _wsSubscription = _channel?.stream.listen(
        (message) {
          print('📩 Message received: $message');
          add(MessageReceived(message: message));
        },
        onError: (error) {
          print('⚠️ WebSocket error: $error');
          emit(ConnectionState(
              markUpModel: state.markUpModel,
              sessionModel: state.sessionModel,
              connectedUserModel: state.connectedUserModel,
              status: ConnectionStatus.error,
              errorMessage: error.toString(),
              channel: _channel));
        },
        onDone: () {
          print('🔚 WebSocket connection closed');
          if (state.status != ConnectionStatus.disconnected) {
            _scheduleReconnect();
          }
        },
        cancelOnError: false,
      );
    } catch (e) {
      print('❌ Connection error: $e');
      emit(ConnectionState(
          markUpModel: state.markUpModel,
          sessionModel: state.sessionModel,
          connectedUserModel: state.connectedUserModel,
          status: ConnectionStatus.error,
          errorMessage: e.toString()));
      _scheduleReconnect();
    }
  }

  void _onDisconnect(
      DisconnectWebSocket event, Emitter<ConnectionState> emit) async {
    print('🔌 Disconnecting WebSocket');
    await _wsSubscription?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _reconnectTimer?.cancel();
    emit(ConnectionState(
        markUpModel: state.markUpModel,
        sessionModel: state.sessionModel,
        status: ConnectionStatus.disconnected,
        connectedUserModel: state.connectedUserModel));
    print('✅ WebSocket disconnected successfully');
  }

  void _onReconnect(ReconnectWebSocket event, Emitter<ConnectionState> emit) {
    if (state.status != ConnectionStatus.connected) {
      print('🔄 Reconnecting to WebSocket');
      add(ConnectWebSocket(eventId: eventId, position: position));
    }
  }

  void _onMessageReceived(
      MessageReceived event, Emitter<ConnectionState> emit) {
    print('📨 Processing received message: ${event.message}');
    try {
      final data = jsonDecode(event.message);
      if (data['type'] == 'session') {
        print('🕒 Session update: ${data['duration']} seconds remaining');
        print('👥 User session : $data');

        try {
          sessionModel = SessionModel.fromJson(data);
          print("session user model success POS  ${sessionModel?.duration}");
        } catch (e) {
          print("session user model exception $e");
        }
      } else if (data['type'] == 'info') {
        print('ℹ️ Info message: ${data['message']}');

        infoMessage = data['message'];
      } else if (data['type'] == 'userDetails') {
        print('👥 User connection details: ${data['details']}');

        try {
          connectedUserModel = ConnectedUserModel.fromJson(data);
          print(
              "connect user model success cornerareferee  ${connectedUserModel?.details.cornerAReferee}");
        } catch (e) {
          print("connect user model exception $e");
        }
      } else if (data['type'] == 'mark') {
        print('👥 User connection mark: $data');

        try {
          markUpModel = MarkUpModel.fromJson(data);
          print("markUpModel user model success POS  ${markUpModel?.position}");
        } catch (e) {
          print("mark user model exception $e");
        }
      } else {
        print('📥 Other message received');
      }

      emit(ConnectionState(
          status: state.status,
          channel: state.channel,
          infoMessage: infoMessage,
          markUpModel: markUpModel,
          sessionModel: sessionModel,
          connectedUserModel: connectedUserModel));
    } catch (e) {
      print('❌ Error processing message: $e');
    }
  }

  void _onStartTimer(StartTimer event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'start_timer',
      'role': event.role,
      'event': eventId,
      'position': event.position,
    });
    print('⏳ Sending start timer request: $payload');
    _channel?.sink.add(payload);
  }

  void _onMarkScore(MarkScore event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'mark',
      'mark': event.mark,
      'role': event.role,
      'event': eventId,
      'position': event.position,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
    print('🏅 Sending mark score request: $payload');
    _channel?.sink.add(payload);
  }

  void _scheduleReconnect() {
    if (state.status == ConnectionStatus.connected) return;
    _reconnectTimer?.cancel();
    print('⏰ Reconnecting in 5 seconds');
    _reconnectTimer =
        Timer(Duration(seconds: 5), () => add(ReconnectWebSocket()));
  }

  @override
  Future<void> close() async {
    print('🛑 Closing ConnectionBloc');
    await _connectivitySubscription?.cancel();
    await _wsSubscription?.cancel();
    await _channel?.sink.close();
    _reconnectTimer?.cancel();
    return super.close();
  }
}
