part of 'event_bloc.dart';

class EventState {
  EventState({required this.isLoading, required this.events});
  bool isLoading;
  List<EventRespModel> events;
}

final class EventInitial extends EventState {
  EventInitial() : super(isLoading: false, events: []);
}
