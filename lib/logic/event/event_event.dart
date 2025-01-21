part of 'event_bloc.dart';

abstract class EventEvent {}

class CreateEvent extends EventEvent {
  CreateEventRequest createEventRequest;
  BuildContext context;

  CreateEvent({required this.createEventRequest, required this.context});
}

class GetEvent extends EventEvent {}

class GetEventParticipants extends EventEvent {
  String eventId;

  GetEventParticipants({required this.eventId});
}
