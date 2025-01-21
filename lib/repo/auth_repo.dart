import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';

import '../config/shared_prefs_config.dart';

class AuthRepository {
  final String baseUrl = ApiConstants.baseUrl;

  Future<Map<String, dynamic>?> logInUser({
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse(
        baseUrl + ApiConstants.login); // Replace with your actual endpoint

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

  Future<void> postUserData(
      {required String fName,
      required String lName,
      required String email,
      required String phone,
      required String role,
      required String passsword,
      required String city,
      required String state,
      required String country,
      required String zipCode}) async {
    final url = Uri.parse(
        baseUrl + ApiConstants.signUp); // Replace with your actual URL

    // Prepare the body data
    final bodyData = {
      'fname': fName, // First name
      'lname': lName, // Last name
      'email': email, // Email address
      'phone': phone, // Phone number
      'role': role, // Role
      'password': passsword, // Password
      'city': city, // City
      'state': state, // State
      'country': country, // Country
      'zipcode': zipCode, // Zipcode
    };

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      // Check if the response status code is 200 (success)
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        // Handle error if status code is not 200
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error making the request: $e');
    }
  }

  Future<bool> createParticipant(
      {required String fName,
      required String eventId,
      required String lName,
      required String email,
      required String phone,
      required String role,
      DateTime? dob,
      double? weight,
      String? gender,
      required String city,
      required String state,
      required String country,
      required String zipCode}) async {
    final url = Uri.parse(baseUrl +
        ApiConstants.createParticipant); // Replace with your actual URL

    // Prepare the body data
    final bodyData = {
      'eventId': eventId,
      'fname': fName, // First name
      'lname': lName, // Last name
      'email': email, // Email address
      'phone': phone, // Phone number
      'role': role, // Role
      'city': city, // City
      'state': state, // State
      'country': country, // Country
      'zipcode': zipCode, // Zipcode
      "dob": dob.toString(),
      "gender": gender,
      "weight": weight,
    };

    try {
      final bearerToken =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(bodyData),
      );

      // Check if the response status code is 200 (success)
      if (response.statusCode == 200) {
        print('Create participant  Success: ${response.body}');
        return true;
      } else {
        // Handle error if status code is not 200
        print(
            'Create participant  Error: ${response.statusCode}, ${response.body}  bodyy ::: $bodyData');
        return false;
      }
    } catch (e) {
      // Handle any errors during the request
      print('Create participant   Error making the request: $e');
      return false;
    }
  }
}
