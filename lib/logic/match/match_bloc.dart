import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  Timer? _timer;

  MatchBloc() : super(MatchInitial()) {
    on<StartMatch>(_onStartMatch);
    on<PauseMatch>(_onPauseMatch);
    on<StopMatch>(_onStopMatch);
    on<UpdateScore>(_onUpdateScore);
    on<UpdateTimer>(_onUpdateTimer);
  }

  void _onStartMatch(StartMatch event, Emitter<MatchState> emit) {
    if (!state.isActive) {
      _startTimer();
      emit(MatchState(
        isActive: true,
        isPaused: false,
        timeRemaining: state.timeRemaining,
        playerOneScores: state.playerOneScores,
        playerTwoScores: state.playerTwoScores,
        connectedReferees: state.connectedReferees,
        isJuryConnected: state.isJuryConnected,
      ));
    }
  }

  void _onPauseMatch(PauseMatch event, Emitter<MatchState> emit) {
    _timer?.cancel();
    emit(MatchState(
      isActive: state.isActive,
      isPaused: true,
      timeRemaining: state.timeRemaining,
      playerOneScores: state.playerOneScores,
      playerTwoScores: state.playerTwoScores,
      connectedReferees: state.connectedReferees,
      isJuryConnected: state.isJuryConnected,
    ));
  }

  void _onStopMatch(StopMatch event, Emitter<MatchState> emit) {
    _timer?.cancel();
    emit(MatchState(
      isActive: false,
      isPaused: false,
      timeRemaining: state.timeRemaining,
      playerOneScores: state.playerOneScores,
      playerTwoScores: state.playerTwoScores,
      connectedReferees: state.connectedReferees,
      isJuryConnected: state.isJuryConnected,
    ));
  }

  void _onUpdateScore(UpdateScore event, Emitter<MatchState> emit) {
    if (!state.isActive || state.isPaused) return;

    if (event.playerId == 'player_one') {
      final newScores = Map<String, int>.from(state.playerOneScores);
      newScores[event.refereeId] = event.points;
      emit(MatchState(
        isActive: state.isActive,
        isPaused: state.isPaused,
        timeRemaining: state.timeRemaining,
        playerOneScores: newScores,
        playerTwoScores: state.playerTwoScores,
        connectedReferees: state.connectedReferees,
        isJuryConnected: state.isJuryConnected,
      ));
    } else {
      final newScores = Map<String, int>.from(state.playerTwoScores);
      newScores[event.refereeId] = event.points;
      emit(MatchState(
        isActive: state.isActive,
        isPaused: state.isPaused,
        timeRemaining: state.timeRemaining,
        playerOneScores: state.playerOneScores,
        playerTwoScores: newScores,
        connectedReferees: state.connectedReferees,
        isJuryConnected: state.isJuryConnected,
      ));
    }
  }

  void _onUpdateTimer(UpdateTimer event, Emitter<MatchState> emit) {
    if (state.timeRemaining > 0) {
      emit(MatchState(
        isActive: state.isActive,
        isPaused: state.isPaused,
        timeRemaining: state.timeRemaining - 1,
        playerOneScores: state.playerOneScores,
        playerTwoScores: state.playerTwoScores,
        connectedReferees: state.connectedReferees,
        isJuryConnected: state.isJuryConnected,
      ));
    } else {
      _timer?.cancel();
      emit(MatchState(
        isActive: false,
        isPaused: false,
        timeRemaining: state.timeRemaining,
        playerOneScores: state.playerOneScores,
        playerTwoScores: state.playerTwoScores,
        connectedReferees: state.connectedReferees,
        isJuryConnected: state.isJuryConnected,
      ));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(UpdateTimer());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
