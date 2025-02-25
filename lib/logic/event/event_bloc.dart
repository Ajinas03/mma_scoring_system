import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/models/create_event_model.dart';
import 'package:my_app/models/get_participants_model.dart';
import 'package:my_app/models/round_analytics_model.dart';
import 'package:my_app/repo/event_repo.dart';

import '../../models/competetion_model.dart';
import '../../models/event_resp_model.dart';
import '../../screen/round/round_analytics_display.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<EventEvent>((event, emit) async {
      if (event is GetEvent) {
        emit(EventState(isLoading: true, events: state.events));

        final items = await EventRepo.getEvents();

        emit(EventState(isLoading: false, events: items));
      }

      if (event is CreateEvent) {
        emit(EventState(isLoading: true, events: state.events));

        final resp = await EventRepo.createEvent(
            event: event.createEventRequest, context: event.context);

        if (resp.success) {
          emit(EventState(isLoading: false, events: state.events));
        } else {
          emit(EventState(isLoading: false, events: state.events));
        }

        print(resp);
      }

      if (event is GetEventParticipants) {
        final getParticipants = await EventRepo.getParticipants(event.eventId);
        emit(EventState(
            isLoading: false,
            events: state.events,
            getParicipantsModel: getParticipants));
      }

      if (event is CreateCompetetionEvent) {
        final response = await EventRepo().createMatch(
          context: event.context,
          eventId: event.eventId,
          redCornerPlayerId: event.redCornerPlayerId,
          blueCornerPlayerId: event.blueCornerPlayerId,
          cornerARefereeId: event.cornerARefereeId,
          cornerBRefereeId: event.cornerBRefereeId,
          cornerCRefereeId: event.cornerCRefereeId,
          blueCornerPlayerName: event.blueCornerPlayerName,
          cornerBRefereeName: event.cornerBRefereeName,
          cornerCRefereeName: event.cornerCRefereeName,
          redCornerPlayerName: event.redCornerPlayerName,
          cornerARefereeName: event.cornerARefereeName,
        );
        print(response);
      }

      if (event is GetCompetetion) {
        emit(EventState(
            isLoading: true,
            events: state.events,
            getParicipantsModel: state.getParicipantsModel));

        final competetionModel =
            await EventRepo.getCompetitionDetails(event.eventId);

        emit(EventState(
            isLoading: false,
            events: state.events,
            getParicipantsModel: state.getParicipantsModel,
            competetionModel: competetionModel));
      }

      if (event is GetRoundAnalytics) {
        emit(EventState(
            isLoading: false,
            isAnalyticsLoading: true,
            events: state.events,
            competetionModel: state.competetionModel,
            getParicipantsModel: state.getParicipantsModel));

        final analytics = await EventRepo.getRoundAnalytics(
            context: event.context,
            competitionId: event.competitionId,
            round: event.round,
            position: event.position);

        if (event.isFromMark) {
          pushReplaceScreen(
              event.context,
              RoundAnalyticsDisplay(
                eventId: event.eventId,
              ));
        } else {
          pushScreen(
              event.context,
              RoundAnalyticsDisplay(
                eventId: event.eventId,
              ));
        }

        emit(EventState(
            isLoading: false,
            isAnalyticsLoading: false,
            events: state.events,
            roundAnalyticsModel: analytics,
            getParicipantsModel: state.getParicipantsModel,
            competetionModel: state.competetionModel));
      }
    });
  }
}
