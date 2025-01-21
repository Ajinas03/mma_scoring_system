part of 'event_bloc.dart';

class EventState {
  EventState(
      {required this.isLoading,
      required this.events,
      this.getParicipantsModel});
  bool isLoading;
  List<EventRespModel> events;
  GetParicipantsModel? getParicipantsModel;
}

final class EventInitial extends EventState {
  EventInitial() : super(isLoading: false, events: []);
}
