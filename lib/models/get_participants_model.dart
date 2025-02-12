import 'dart:convert';

GetParicipantsModel? getParicipantsModelFromJson(String str) =>
    str.isNotEmpty ? GetParicipantsModel.fromJson(json.decode(str)) : null;

String getParicipantsModelToJson(GetParicipantsModel? data) =>
    json.encode(data?.toJson() ?? {});

class GetParicipantsModel {
  String? eventId;
  List<Jury>? players;
  List<Jury>? jury;
  List<Jury>? referees;

  GetParicipantsModel({
    this.eventId,
    this.players,
    this.jury,
    this.referees,
  });

  factory GetParicipantsModel.fromJson(Map<String, dynamic> json) =>
      GetParicipantsModel(
        eventId: json["eventId"],
        players: json["players"] != null
            ? List<Jury>.from(json["players"].map((x) => Jury.fromJson(x)))
            : null,
        jury: json["jury"] != null
            ? List<Jury>.from(json["jury"].map((x) => Jury.fromJson(x)))
            : null,
        referees: json["referees"] != null
            ? List<Jury>.from(json["referees"].map((x) => Jury.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "players": players != null
            ? List<dynamic>.from(players!.map((x) => x.toJson()))
            : null,
        "jury": jury != null
            ? List<dynamic>.from(jury!.map((x) => x.toJson()))
            : null,
        "referees": referees != null
            ? List<dynamic>.from(referees!.map((x) => x.toJson()))
            : null,
      };
}

class Jury {
  String? phone;
  String? fname;
  String? lname;
  String? username;
  String? userId;
  String? eventId;
  String? role;
  String? city;
  String? state;
  String? country;
  String? email;
  DateTime? dob;
  String? gender;
  double? weight;
  String? zipcode;

  Jury({
    this.phone,
    this.fname,
    this.lname,
    this.username,
    this.userId,
    this.eventId,
    this.role,
    this.city,
    this.state,
    this.country,
    this.email,
    this.dob,
    this.gender,
    this.weight,
    this.zipcode,
  });

  factory Jury.fromJson(Map<String, dynamic> json) => Jury(
        phone: json["phone"],
        fname: json["fname"],
        lname: json["lname"],
        username: json["username"],
        userId: json["userId"],
        eventId: json["eventId"],
        role: json["role"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        email: json["email"],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        gender: json["gender"],
        weight: json["weight"]?.toDouble(),
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "fname": fname,
        "lname": lname,
        "username": username,
        "userId": userId,
        "eventId": eventId,
        "role": role,
        "city": city,
        "state": state,
        "country": country,
        "email": email,
        "dob": dob?.toIso8601String(),
        "gender": gender,
        "weight": weight,
        "zipcode": zipcode,
      };
}
