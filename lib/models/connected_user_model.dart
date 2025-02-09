import 'dart:convert';

ConnectedUserModel connectedUserModelFromJson(String str) =>
    ConnectedUserModel.fromJson(json.decode(str));

String connectedUserModelToJson(ConnectedUserModel data) =>
    json.encode(data.toJson());

class ConnectedUserModel {
  String type;
  Details details;
  bool sessionActive;

  ConnectedUserModel({
    required this.type,
    required this.details,
    required this.sessionActive,
  });

  factory ConnectedUserModel.fromJson(Map<String, dynamic> json) =>
      ConnectedUserModel(
        type: json["type"],
        details: Details.fromJson(json["details"]),
        sessionActive: json["sessionActive"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "details": details.toJson(),
        "sessionActive": sessionActive,
      };
}

class Details {
  CornerAReferee mainJury;
  CornerAReferee cornerAReferee;
  CornerAReferee cornerBReferee;
  CornerAReferee cornerCReferee;

  Details({
    required this.mainJury,
    required this.cornerAReferee,
    required this.cornerBReferee,
    required this.cornerCReferee,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        mainJury: CornerAReferee.fromJson(json["mainJury"]),
        cornerAReferee: CornerAReferee.fromJson(json["CornerAReferee"]),
        cornerBReferee: CornerAReferee.fromJson(json["CornerBReferee"]),
        cornerCReferee: CornerAReferee.fromJson(json["CornerCReferee"]),
      );

  Map<String, dynamic> toJson() => {
        "mainJury": mainJury.toJson(),
        "CornerAReferee": cornerAReferee.toJson(),
        "CornerBReferee": cornerBReferee.toJson(),
        "CornerCReferee": cornerCReferee.toJson(),
      };
}

class CornerAReferee {
  bool isConnected;

  CornerAReferee({
    required this.isConnected,
  });

  factory CornerAReferee.fromJson(Map<String, dynamic> json) => CornerAReferee(
        isConnected: json["isConnected"],
      );

  Map<String, dynamic> toJson() => {
        "isConnected": isConnected,
      };
}
