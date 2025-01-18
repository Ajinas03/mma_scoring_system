import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';

class AuthRepository {
  // final String baseUrl =

  Future<Map<String, dynamic>?> logInUser({
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.login); // Replace with your actual endpoint

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // For error responses (e.g., 404, 400, etc.), return the error message
        final errorResponse = jsonDecode(response.body);
        return errorResponse; // Contains the 'detail' field or other error details
      }
    } catch (e) {
      print('HTTP Error: $e');
      return null;
    }
  }
}
