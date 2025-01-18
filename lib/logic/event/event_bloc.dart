import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/create_event_model.dart';
import 'package:my_app/repo/event_repo.dart';

import '../../models/event_resp_model.dart';

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

        final resp = EventRepo.createEvent(
            event: event.createEventRequest, context: event.context);
        emit(EventState(isLoading: false, events: state.events));
        print(resp);
      }
    });
  }
}
