part of 'event_bloc.dart';

class EventState {
  EventState(
      {required this.isLoading,
      required this.events,
      this.getParicipantsModel,
      this.competetionModel,
      this.roundAnalyticsModel});
  bool isLoading;
  List<EventRespModel> events;
  List<CompetetionModel>? competetionModel;
  GetParicipantsModel? getParicipantsModel;
  RoundAnalyticsModel? roundAnalyticsModel;
}

final class EventInitial extends EventState {
  EventInitial() : super(isLoading: false, events: []);
}
