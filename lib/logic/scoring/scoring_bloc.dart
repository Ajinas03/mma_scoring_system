import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import './scoring_event.dart';
import './scoring_state.dart';

class ScoringBloc extends Bloc<ScoringEvent, ScoringState> {
  WebSocketChannel? _channel;

  ScoringBloc() : super(ScoringInitial()) {
    on<ConnectToMatch>(_onConnectToMatch);
    on<UpdateScore>(_onUpdateScore);
    on<DisconnectFromMatch>(_onDisconnectFromMatch);
  }

  void _onConnectToMatch(ConnectToMatch event, Emitter<ScoringState> emit) {
    try {
      // final wsUrl = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.scoringEndpoint}/${event.matchId}');
      // _channel = WebSocketChannel.connect(wsUrl);
      // Handle connection and initial state
    } catch (e) {
      emit(ScoringError('Failed to connect: $e'));
    }
  }

  void _onUpdateScore(UpdateScore event, Emitter<ScoringState> emit) {
    // Handle score updates
  }

  void _onDisconnectFromMatch(
      DisconnectFromMatch event, Emitter<ScoringState> emit) {
    _channel?.sink.close();
    emit(ScoringInitial());
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}
