// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String message;
  String userId;
  String token;
  String username;
  String role;

  AuthModel({
    required this.message,
    required this.userId,
    required this.token,
    required this.username,
    required this.role,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json["message"],
        userId: json["user_id"],
        token: json["token"],
        username: json["username"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "token": token,
        "username": username,
        "role": role,
      };
}
