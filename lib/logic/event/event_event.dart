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

class GetRoundAnalytics extends EventEvent {
  BuildContext context;
  String competitionId;
  int round;
  String position;

  GetRoundAnalytics(
      {required this.competitionId,
      required this.position,
      required this.round,
      required this.context});
}

class GetCompetetion extends EventEvent {
  String eventId;

  GetCompetetion({required this.eventId});
}

class CreateCompetetionEvent extends EventEvent {
  BuildContext context;
  String eventId;
  String redCornerPlayerId;
  String blueCornerPlayerId;
  String cornerARefereeId;
  String cornerBRefereeId;
  String cornerCRefereeId;
  String redCornerPlayerName;
  String blueCornerPlayerName;
  String cornerARefereeName;
  String cornerBRefereeName;
  String cornerCRefereeName;

  CreateCompetetionEvent(
      {required this.context,
      required this.eventId,
      required this.redCornerPlayerId,
      required this.blueCornerPlayerId,
      required this.cornerARefereeId,
      required this.cornerBRefereeId,
      required this.cornerCRefereeId,
      required this.blueCornerPlayerName,
      required this.cornerARefereeName,
      required this.cornerBRefereeName,
      required this.cornerCRefereeName,
      required this.redCornerPlayerName});
}
