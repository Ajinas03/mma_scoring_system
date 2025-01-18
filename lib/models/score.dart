class Score {
  final String participantId;
  final int punches;
  final int kicks;
  final int knees;
  final String refereeId;

  Score({
    required this.participantId,
    required this.punches,
    required this.kicks,
    required this.knees,
    required this.refereeId,
  });

  int get totalScore => punches + kicks + knees;

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      participantId: json['participantId'],
      punches: json['punches'],
      kicks: json['kicks'],
      knees: json['knees'],
      refereeId: json['refereeId'],
    );
  }
}