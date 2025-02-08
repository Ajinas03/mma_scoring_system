class ApiConstants {
  // static const String baseUrl = 'wss://your-socket-server.com';
  // static const String eventsEndpoint = '/events';
  // static const String scoringEndpoint = '/scoring';

  // // Socket events
  // static const String connectEvent = 'connect';
  // static const String scoreUpdateEvent = 'score_update';
  // static const String finalScoreEvent = 'final_score';

  static const String baseUrl =
      "https://masternode-856921708890.asia-south1.run.app";
  static const String login = "/api/v1.0/login";
  static const String createParticipant = "/api/v1.0/create-participant";
  static const String getEvents = "/api/v1.0/events";
  static const String createEvent = "/api/v1.0/create_event";
  static const String signUp = "/api/v1.0/signup";
  static const String getParticipants = "/api/v1.0/get-participants/";
  static const String createMatch = "/api/v1.0/create-competition";
  static const String checkUserExist = "/api/v1.0/check-userexist/";
  static const String addParticipantToEvent = "/api/v1.0/addParticipantToEvent";
  static const String getCompetitionDetails = " api/v1.0/competition-details";
  static const String updateRoundStatus = '/api/v1.0/update-round-status';
  static const String getRoundDetails = '/api/v1.0/getRoundDetails';
}
