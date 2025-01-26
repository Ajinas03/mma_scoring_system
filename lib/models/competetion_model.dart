// To parse this JSON data, do
//
//     final competetionModel = competetionModelFromJson(jsonString);

import 'dart:convert';

List<CompetetionModel> competetionModelFromJson(String str) =>
    List<CompetetionModel>.from(
        json.decode(str).map((x) => CompetetionModel.fromJson(x)));

String competetionModelToJson(List<CompetetionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompetetionModel {
  String eventId;
  CornerAReferee redCornerPlayer;
  CornerAReferee blueCornerPlayer;
  CornerAReferee cornerAReferee;
  CornerAReferee cornerBReferee;
  CornerAReferee cornerCReferee;
  int rounds;
  DateTime createdAt;
  List<RoundsDetail> roundsDetails;
  String id;

  CompetetionModel({
    required this.eventId,
    required this.redCornerPlayer,
    required this.blueCornerPlayer,
    required this.cornerAReferee,
    required this.cornerBReferee,
    required this.cornerCReferee,
    required this.rounds,
    required this.createdAt,
    required this.roundsDetails,
    required this.id,
  });

  factory CompetetionModel.fromJson(Map<String, dynamic> json) =>
      CompetetionModel(
        eventId: json["eventId"],
        redCornerPlayer: CornerAReferee.fromJson(json["redCornerPlayer"]),
        blueCornerPlayer: CornerAReferee.fromJson(json["blueCornerPlayer"]),
        cornerAReferee: CornerAReferee.fromJson(json["CornerAReferee"]),
        cornerBReferee: CornerAReferee.fromJson(json["CornerBReferee"]),
        cornerCReferee: CornerAReferee.fromJson(json["CornerCReferee"]),
        rounds: json["rounds"],
        createdAt: DateTime.parse(json["createdAt"]),
        roundsDetails: List<RoundsDetail>.from(
            json["roundsDetails"].map((x) => RoundsDetail.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "redCornerPlayer": redCornerPlayer.toJson(),
        "blueCornerPlayer": blueCornerPlayer.toJson(),
        "CornerAReferee": cornerAReferee.toJson(),
        "CornerBReferee": cornerBReferee.toJson(),
        "CornerCReferee": cornerCReferee.toJson(),
        "rounds": rounds,
        "createdAt": createdAt.toIso8601String(),
        "roundsDetails":
            List<dynamic>.from(roundsDetails.map((x) => x.toJson())),
        "id": id,
      };
}

class CornerAReferee {
  String id;
  String name;

  CornerAReferee({
    required this.id,
    required this.name,
  });

  factory CornerAReferee.fromJson(Map<String, dynamic> json) => CornerAReferee(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class RoundsDetail {
  int status;
  int round;
  List<dynamic> history;

  RoundsDetail({
    required this.status,
    required this.round,
    required this.history,
  });

  factory RoundsDetail.fromJson(Map<String, dynamic> json) => RoundsDetail(
        status: json["status"],
        round: json["round"],
        history: List<dynamic>.from(json["history"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "round": round,
        "history": List<dynamic>.from(history.map((x) => x)),
      };
}
