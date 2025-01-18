// To parse this JSON data, do
//
//     final eventRespModel = eventRespModelFromJson(jsonString);

import 'dart:convert';

List<EventRespModel> eventRespModelFromJson(String str) =>
    List<EventRespModel>.from(
        json.decode(str).map((x) => EventRespModel.fromJson(x)));

String eventRespModelToJson(List<EventRespModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventRespModel {
  String eventId;
  String name;
  String category;
  DateTime date;
  String address;
  String state;
  String country;
  String zipcode;

  EventRespModel({
    required this.eventId,
    required this.name,
    required this.category,
    required this.date,
    required this.address,
    required this.state,
    required this.country,
    required this.zipcode,
  });

  factory EventRespModel.fromJson(Map<String, dynamic> json) => EventRespModel(
        eventId: json["event_id"],
        name: json["name"],
        category: json["category"],
        date: DateTime.parse(json["date"]),
        address: json["address"],
        state: json["state"],
        country: json["country"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "name": name,
        "category": category,
        "date": date.toIso8601String(),
        "address": address,
        "state": state,
        "country": country,
        "zipcode": zipcode,
      };
}
