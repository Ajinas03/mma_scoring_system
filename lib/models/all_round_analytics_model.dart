// To parse this JSON data, do
//
//     final allRoundAnalytics = allRoundAnalyticsFromJson(jsonString);

import 'dart:convert';

AllRoundAnalytics allRoundAnalyticsFromJson(String str) =>
    AllRoundAnalytics.fromJson(json.decode(str));

String allRoundAnalyticsToJson(AllRoundAnalytics data) =>
    json.encode(data.toJson());

class AllRoundAnalytics {
  List<RoundsDetail> roundsDetails;

  AllRoundAnalytics({
    required this.roundsDetails,
  });

  factory AllRoundAnalytics.fromJson(Map<String, dynamic> json) =>
      AllRoundAnalytics(
        roundsDetails: List<RoundsDetail>.from(
            json["RoundsDetails"].map((x) => RoundsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RoundsDetails":
            List<dynamic>.from(roundsDetails.map((x) => x.toJson())),
      };
}

class RoundsDetail {
  int round;
  List<RoundedScore> roundedScores;
  String roundWinner;
  String roundWonType;

  RoundsDetail({
    required this.round,
    required this.roundedScores,
    required this.roundWinner,
    required this.roundWonType,
  });

  factory RoundsDetail.fromJson(Map<String, dynamic> json) => RoundsDetail(
        round: json["round"],
        roundedScores: List<RoundedScore>.from(
            json["RoundedScores"].map((x) => RoundedScore.fromJson(x))),
        roundWinner: json["RoundWinner"],
        roundWonType: json["RoundWonType"],
      );

  Map<String, dynamic> toJson() => {
        "round": round,
        "RoundedScores":
            List<dynamic>.from(roundedScores.map((x) => x.toJson())),
        "RoundWinner": roundWinner,
        "RoundWonType": roundWonType,
      };
}

class RoundedScore {
  String position;
  int redTotalRoundedScore;
  int blueTotalRoundedScore;
  List<int> totalPointRed;
  List<int> totalPointBlue;
  String won;
  String wonType;

  RoundedScore({
    required this.position,
    required this.redTotalRoundedScore,
    required this.blueTotalRoundedScore,
    required this.totalPointRed,
    required this.totalPointBlue,
    required this.won,
    required this.wonType,
  });

  factory RoundedScore.fromJson(Map<String, dynamic> json) => RoundedScore(
        position: json["position"],
        redTotalRoundedScore: json["redTotalRoundedScore"],
        blueTotalRoundedScore: json["blueTotalRoundedScore"],
        totalPointRed: List<int>.from(json["totalPointRed"].map((x) => x)),
        totalPointBlue: List<int>.from(json["totalPointBlue"].map((x) => x)),
        won: json["won"],
        wonType: json["wonType"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "redTotalRoundedScore": redTotalRoundedScore,
        "blueTotalRoundedScore": blueTotalRoundedScore,
        "totalPointRed": List<dynamic>.from(totalPointRed.map((x) => x)),
        "totalPointBlue": List<dynamic>.from(totalPointBlue.map((x) => x)),
        "won": won,
        "wonType": wonType,
      };
}
