import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
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
  String competitionId = '';
  String position = '';
  int round = 0;
  StreamSubscription? _connectivitySubscription;
  StreamSubscription? _wsSubscription;
  final _audioPlayer = AudioPlayer();

  ConnectionBloc() : super(ConnectionInitial()) {
    print('🚀 Initializing ConnectionBloc');
    _initAudio();

    on<ConnectWebSocket>(_onConnect);
    on<DisconnectWebSocket>(_onDisconnect);
    on<ReconnectWebSocket>(_onReconnect);
    on<MessageReceived>(_onMessageReceived);
    on<StartTimer>(_onStartTimer);
    on<PauseTimer>(_onPauseTimer);
    on<StopTimer>(_onStopTimer);
    on<ResumeTimer>(_onResumeTimer);

    on<MarkScore>(_onMarkScore);

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      print('📡 Connectivity changed: $result');
      if (result != ConnectivityResult.none) {
        add(ReconnectWebSocket());
      }
    });
  }

  Future<void> _initAudio() async {
    try {
      // Load the audio file from your assets
      await _audioPlayer.setAsset('assets/message-alert-190042.mp3');
      print('🔊 Audio initialized successfully');
    } catch (e) {
      print('❌ Error initializing audio: $e');
    }
  }

  Future<void> _playNotificationSound() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
      print('🔔 Playing notification sound');
    } catch (e) {
      print('❌ Error playing audio: $e');
    }
  }

  void _onConnect(ConnectWebSocket event, Emitter<ConnectionState> emit) async {
    try {
      print('🔌 Connecting to WebSocket');
      await _wsSubscription?.cancel();
      emit(ConnectionState(
          isPauseTimer: state.isPauseTimer,
          isStartTimer: state.isStartTimer,
          markUpModel: state.markUpModel,
          sessionModel: state.sessionModel,
          status: ConnectionStatus.connecting,
          connectedUserModel: state.connectedUserModel));

      final wsUrl =
          'wss://masternode-856921708890.asia-south1.run.app/ws/v1.0/livePool';
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      competitionId = event.competitionId;

      position = event.position;
      final userRole =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole);
      round = event.round;
      final connectionMessage = jsonEncode({
        "username": userRole,
        "role": userRole,
        "competitionId": event.competitionId,
        "position": position,
        "round": event.round
      });
      _channel?.sink.add(connectionMessage);
      print("connection payload xxxxxxxxxxx $connectionMessage");
      emit(ConnectionState(
          isPauseTimer: state.isPauseTimer,
          isStartTimer: state.isStartTimer,
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
              isPauseTimer: state.isPauseTimer,
              isStartTimer: state.isStartTimer,
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
          isPauseTimer: state.isPauseTimer,
          isStartTimer: state.isStartTimer,
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
        isPauseTimer: false,
        isStartTimer: false,
        markUpModel: state.markUpModel,
        sessionModel: state.sessionModel,
        status: ConnectionStatus.disconnected,
        connectedUserModel: state.connectedUserModel));
    print('✅ WebSocket disconnected successfully');
  }

  void _onReconnect(ReconnectWebSocket event, Emitter<ConnectionState> emit) {
    if (state.status != ConnectionStatus.connected) {
      print('🔄 Reconnecting to WebSocket');
      add(ConnectWebSocket(
          competitionId: competitionId, position: position, round: round));
    }
  }

  void _onMessageReceived(
      MessageReceived event, Emitter<ConnectionState> emit) {
    HapticFeedback.mediumImpact();
    print('📨 Processing received message: ${event.message}');

    try {
      final data = jsonDecode(event.message);
      bool shouldPlaySound = false;

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
        shouldPlaySound = true; // Play sound for session updates

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

      if (shouldPlaySound) {
        HapticFeedback.mediumImpact();
        _playNotificationSound();
      }

      emit(ConnectionState(
          isPauseTimer: state.isPauseTimer,
          isStartTimer: state.isStartTimer,
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
      'event': competitionId,
      'position': event.position,
    });
    print('⏳ Sending start timer request: $payload');

    _channel?.sink.add(payload);

    emit(ConnectionState(
        status: state.status,
        channel: state.channel,
        infoMessage: infoMessage,
        markUpModel: markUpModel,
        sessionModel: sessionModel,
        connectedUserModel: connectedUserModel,
        isStartTimer: true,
        isPauseTimer: false));
  }

  void _onPauseTimer(PauseTimer event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'pause_timer',
      'role': event.role,
      'event': competitionId,
      'position': event.position,
    });
    print('⏳ Sending Pause timer request: $payload');
    _channel?.sink.add(payload);
    emit(ConnectionState(
        status: state.status,
        channel: state.channel,
        infoMessage: infoMessage,
        markUpModel: markUpModel,
        sessionModel: sessionModel,
        connectedUserModel: connectedUserModel,
        isStartTimer: true,
        isPauseTimer: true));
  }

  void _onResumeTimer(ResumeTimer event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'resume_timer',
      'role': event.role,
      'event': competitionId,
      'position': event.position,
    });
    print('⏳ Sending resume timer request: $payload');
    _channel?.sink.add(payload);
    emit(ConnectionState(
        status: state.status,
        channel: state.channel,
        infoMessage: infoMessage,
        markUpModel: markUpModel,
        sessionModel: sessionModel,
        connectedUserModel: connectedUserModel,
        isStartTimer: true,
        isPauseTimer: false));
  }

  void _onStopTimer(StopTimer event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'complete_session',
      'role': event.role,
      'event': competitionId,
      'position': event.position,
    });
    emit(ConnectionState(
        status: state.status,
        channel: state.channel,
        infoMessage: infoMessage,
        markUpModel: markUpModel,
        sessionModel: sessionModel,
        connectedUserModel: connectedUserModel,
        isStartTimer: false,
        isPauseTimer: false));
    print('⏳ Sending Stop timer request: $payload');
    _channel?.sink.add(payload);
  }

  void _onMarkScore(MarkScore event, Emitter<ConnectionState> emit) {
    final payload = jsonEncode({
      'action': 'mark',
      'mark': event.mark,
      'role': event.role,
      'event': competitionId,
      'position': event.position,
      'ismarkedToRed': event.ismarkedToRed,
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
    await _audioPlayer.dispose();
    await _connectivitySubscription?.cancel();
    await _wsSubscription?.cancel();
    await _channel?.sink.close();
    _reconnectTimer?.cancel();
    return super.close();
  }
}
