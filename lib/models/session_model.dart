// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);

import 'dart:convert';

SessionModel sessionModelFromJson(String str) =>
    SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  String type;
  int duration;
  bool isFinished;
  String reason;

  SessionModel({
    required this.type,
    required this.duration,
    required this.isFinished,
    required this.reason,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        type: json["type"],
        duration: json["duration"],
        isFinished: json["isFinished"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "duration": duration,
        "isFinished": isFinished,
        "reason": reason,
      };
}
