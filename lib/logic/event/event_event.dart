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

class CreateCompetetionEvent extends EventEvent {
  BuildContext context;
  String eventId;
  String redCornerPlayerId;
  String blueCornerPlayerId;
  String cornerARefereeId;
  String cornerBRefereeId;
  String cornerCRefereeId;

  CreateCompetetionEvent({
    required this.context,
    required this.eventId,
    required this.redCornerPlayerId,
    required this.blueCornerPlayerId,
    required this.cornerARefereeId,
    required this.cornerBRefereeId,
    required this.cornerCRefereeId,
  });
}
