import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/login_model.dart';

class AuthRepo {
  static const String apiUrl =

      //  "http://10.0.2.2:8000/login";
      "https://azupcjlygw3yxymrdx4pez3jiu0jragk.lambda-url.ap-south-1.on.aws/login"; // Replace with your API URL

  Future<LoginModel?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userName": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("resp succecc ${response.body}");
        // Parse the response body into LoginModel
        return loginModelFromJson(response.body);
      } else {
        debugPrint("Failed to status code: ${response.statusCode}");
        // Handle error
        debugPrint("Failed to login: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }
}
