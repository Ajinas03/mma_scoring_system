// To parse this JSON data, do
//
//     final markUpModel = markUpModelFromJson(jsonString);

import 'dart:convert';

MarkUpModel markUpModelFromJson(String str) =>
    MarkUpModel.fromJson(json.decode(str));

String markUpModelToJson(MarkUpModel data) => json.encode(data.toJson());

class MarkUpModel {
  String type;
  String position;
  String marked;
  int time;

  MarkUpModel({
    required this.type,
    required this.position,
    required this.marked,
    required this.time,
  });

  factory MarkUpModel.fromJson(Map<String, dynamic> json) => MarkUpModel(
        type: json["type"],
        position: json["position"],
        marked: json["marked"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "position": position,
        "marked": marked,
        "time": time,
      };
}
