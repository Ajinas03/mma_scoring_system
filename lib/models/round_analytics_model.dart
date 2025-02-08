import 'dart:convert';

class RoundAnalyticsModel {
  List<RoundedScore> roundedScores;

  RoundAnalyticsModel({
    required this.roundedScores,
  });

  factory RoundAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return RoundAnalyticsModel(
      roundedScores: (json["RoundedScores"] as List)
          .map((x) => RoundedScore.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "RoundedScores": roundedScores.map((x) => x.toJson()).toList(),
      };
}

class RoundedScore {
  String position;
  int redTotalRoundedScore;
  int blueTotalRoundedScore;
  List<dynamic> totalPointRed;
  List<dynamic> totalPointBlue;
  String won;
  String wonType;
  List<MarkDetail> markDetails;

  RoundedScore({
    required this.position,
    required this.redTotalRoundedScore,
    required this.blueTotalRoundedScore,
    required this.totalPointRed,
    required this.totalPointBlue,
    required this.won,
    required this.wonType,
    required this.markDetails,
  });

  factory RoundedScore.fromJson(Map<String, dynamic> json) {
    return RoundedScore(
      position: json["position"]?.toString() ?? '',
      redTotalRoundedScore: _safeParseInt(json["redTotalRoundedScore"]),
      blueTotalRoundedScore: _safeParseInt(json["blueTotalRoundedScore"]),
      totalPointRed: _safeParseList(json["totalPointRed"]),
      totalPointBlue: _safeParseList(json["totalPointBlue"]),
      won: json["won"]?.toString() ?? '',
      wonType: json["wonType"]?.toString() ?? '',
      markDetails: (json["markDetails"] as List)
          .map((x) => MarkDetail.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "position": position,
        "redTotalRoundedScore": redTotalRoundedScore,
        "blueTotalRoundedScore": blueTotalRoundedScore,
        "totalPointRed": totalPointRed,
        "totalPointBlue": totalPointBlue,
        "won": won,
        "wonType": wonType,
        "markDetails": markDetails.map((x) => x.toJson()).toList(),
      };

  // Helper method to safely parse integers
  static int _safeParseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  // Helper method to safely parse lists
  static List<dynamic> _safeParseList(dynamic value) {
    if (value is List) return value;
    return [];
  }
}

class MarkDetail {
  int mark;
  int timeRemaining;
  int time;
  bool ismarkedToRed;

  MarkDetail({
    required this.mark,
    required this.timeRemaining,
    required this.time,
    required this.ismarkedToRed,
  });

  factory MarkDetail.fromJson(Map<String, dynamic> json) {
    return MarkDetail(
      mark: _safeParseInt(json["mark"]),
      timeRemaining: _safeParseInt(json["time_remaining"]),
      time: _safeParseInt(json["time"]),
      ismarkedToRed: json["ismarkedToRed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "mark": mark,
        "time_remaining": timeRemaining,
        "time": time,
        "ismarkedToRed": ismarkedToRed,
      };

  // Helper method to safely parse integers
  static int _safeParseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}

// Usage example
RoundAnalyticsModel parseRoundAnalytics(String jsonString) {
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return RoundAnalyticsModel.fromJson(jsonMap);
}
