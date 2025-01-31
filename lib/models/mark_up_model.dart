class MarkUpModel {
  String type;
  String position;
  String marked;
  int time;
  bool ismarkedToRed;

  MarkUpModel(
      {required this.type,
      required this.position,
      required this.marked,
      required this.time,
      required this.ismarkedToRed});

  factory MarkUpModel.fromJson(Map<String, dynamic> json) => MarkUpModel(
        type: json["type"],
        position: json["position"],
        marked: json["marked"],
        time: json["time"],
        ismarkedToRed: _parseBool(json["ismarkedToRed"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "position": position,
        "marked": marked,
        "time": time,
        "ismarkedToRed": ismarkedToRed,
      };

  // Helper function to parse the string into a boolean
  static bool _parseBool(dynamic value) {
    if (value is String) {
      return value.toLowerCase() ==
          'true'; // handles string values like "true" or "false"
    }
    return value == true; // if it's already a boolean, return as is
  }
}
