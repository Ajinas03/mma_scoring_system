// To parse this JSON data, do
//
//     final userExistModel = userExistModelFromJson(jsonString);

import 'dart:convert';

UserExistModel userExistModelFromJson(String str) =>
    UserExistModel.fromJson(json.decode(str));

String userExistModelToJson(UserExistModel data) => json.encode(data.toJson());

class UserExistModel {
  String fname;
  String lname;
  String email;
  String phone;
  String role;
  DateTime createdAt;
  String userId;

  UserExistModel({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.userId,
  });

  factory UserExistModel.fromJson(Map<String, dynamic> json) => UserExistModel(
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
      };
}
