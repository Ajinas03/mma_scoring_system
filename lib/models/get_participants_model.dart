// To parse this JSON data, do
//
//     final getParicipantsModel = getParicipantsModelFromJson(jsonString);

import 'dart:convert';

GetParicipantsModel getParicipantsModelFromJson(String str) =>
    GetParicipantsModel.fromJson(json.decode(str));

String getParicipantsModelToJson(GetParicipantsModel data) =>
    json.encode(data.toJson());

class GetParicipantsModel {
  String eventId;
  List<Jury> players;
  List<Jury> jury;
  List<Jury> referees;

  GetParicipantsModel({
    required this.eventId,
    required this.players,
    required this.jury,
    required this.referees,
  });

  factory GetParicipantsModel.fromJson(Map<String, dynamic> json) =>
      GetParicipantsModel(
        eventId: json["eventId"],
        players: List<Jury>.from(json["players"].map((x) => Jury.fromJson(x))),
        jury: List<Jury>.from(json["jury"].map((x) => Jury.fromJson(x))),
        referees:
            List<Jury>.from(json["referees"].map((x) => Jury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
        "jury": List<dynamic>.from(jury.map((x) => x.toJson())),
        "referees": List<dynamic>.from(referees.map((x) => x.toJson())),
      };
}

class Jury {
  String phone;
  String fname;
  String lname;
  String eventId;
  String role;
  String city;
  String state;
  String country;
  String email;
  DateTime dob;
  String gender;
  double weight;
  String zipcode;

  Jury({
    required this.phone,
    required this.fname,
    required this.lname,
    required this.eventId,
    required this.role,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.dob,
    required this.gender,
    required this.weight,
    required this.zipcode,
  });

  factory Jury.fromJson(Map<String, dynamic> json) => Jury(
        phone: json["phone"],
        fname: json["fname"],
        lname: json["lname"],
        eventId: json["eventId"],
        role: json["role"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        weight: json["weight"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "fname": fname,
        "lname": lname,
        "eventId": eventId,
        "role": role,
        "city": city,
        "state": state,
        "country": country,
        "email": email,
        "dob": dob.toIso8601String(),
        "gender": gender,
        "weight": weight,
        "zipcode": zipcode,
      };
}
