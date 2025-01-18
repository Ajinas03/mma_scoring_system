// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String username;
  String role;
  String userid;

  LoginModel({
    required this.username,
    required this.role,
    required this.userid,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["username"],
        role: json["role"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "role": role,
        "userid": userid,
      };
}
