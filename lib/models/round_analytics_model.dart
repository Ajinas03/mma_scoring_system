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

  factory RoundedScore.fromJson(Map<String, dynamic> json) {
    return RoundedScore(
      position: json["position"]?.toString() ?? '',
      redTotalRoundedScore: _safeParseInt(json["redTotalRoundedScore"]),
      blueTotalRoundedScore: _safeParseInt(json["blueTotalRoundedScore"]),
      totalPointRed: _parseIntList(json["totalPointRed"]),
      totalPointBlue: _parseIntList(json["totalPointBlue"]),
      won: json["won"]?.toString() ?? '',
      wonType: json["wonType"]?.toString() ?? '',
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
      };

  // Helper method to safely parse integers
  static int _safeParseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  // Helper method to parse list of integers
  static List<int> _parseIntList(dynamic value) {
    if (value is List) {
      return value.map((item) => _safeParseInt(item)).toList();
    }
    return [];
  }
}
