import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';

import '../config/shared_prefs_config.dart';
import '../models/user_exist_model.dart';

class AuthRepository {
  final String baseUrl = ApiConstants.baseUrl;

  void _logApiCall(String functionName, dynamic requestBody,
      dynamic responseBody, int? statusCode) {
    log('''
=== API Call Log: $functionName ===
Request Body: ${jsonEncode(requestBody)}
Response Status: $statusCode
Response Body: ${jsonEncode(responseBody)}
============================
''');
  }

  Future<Map<String, dynamic>?> logInUser({
    required String phone,
    required String password,
  }) async {
    const functionName = 'logInUser';
    final url = Uri.parse(baseUrl + ApiConstants.login);

    final requestBody = {
      'phone': "91$phone",
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      final responseBody = jsonDecode(response.body);
      _logApiCall(functionName, requestBody, responseBody, response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      _logApiCall(functionName, requestBody, {'error': e.toString()}, null);
      return null;
    }
  }

  Future<void> postUserData({
    required String fName,
    required String lName,
    required String email,
    required String phone,
    required String role,
    required String passsword,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    const functionName = 'postUserData';
    final url = Uri.parse(baseUrl + ApiConstants.signUp);

    final bodyData = {
      'fname': fName,
      'lname': lName,
      'email': email,
      'phone': "91$phone",
      'role': role,
      'password': passsword,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipCode,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      final responseBody =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;
      _logApiCall(functionName, bodyData, responseBody, response.statusCode);
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()}, null);
    }
  }

  Future<bool> createParticipant({
    required String fName,
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
    required String zipCode,
  }) async {
    const functionName = 'createParticipant';
    final url = Uri.parse(baseUrl + ApiConstants.createParticipant);

    final bodyData = {
      'eventId': eventId,
      'fname': fName,
      'lname': lName,
      'email': email,
      'phone': "91$phone",
      'role': role,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipCode,
      'dob': dob?.toString(),
      'gender': gender,
      'weight': weight,
    };

    try {
      final bearerToken =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(bodyData),
      );

      final responseBody =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;
      _logApiCall(functionName, bodyData, responseBody, response.statusCode);

      return response.statusCode == 200;
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()}, null);
      return false;
    }
  }

  Future<UserExistModel?> checkUserExist({
    required String phone,
  }) async {
    const functionName = 'checkUserExist';
    final url = Uri.parse("$baseUrl${ApiConstants.checkUserExist}91$phone");
    final requestParams = {'phone': "91$phone"};

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final responseBody =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;
      _logApiCall(
          functionName, requestParams, responseBody, response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserExistModel.fromJson(responseBody);
      }
      return null;
    } catch (e) {
      _logApiCall(functionName, requestParams, {'error': e.toString()}, null);
      return null;
    }
  }

  Future<bool> addParticipantToEvent({
    required String userId,
    required String eventId,
    required String phone,
    required String fname,
    required String lname,
    required String role,
  }) async {
    const functionName = 'addParticipantToEvent';
    final url = Uri.parse(baseUrl + ApiConstants.addParticipantToEvent);

    final bodyData = {
      'userId': userId,
      'eventId': eventId,
      'phone': "91$phone",
      'fname': fname,
      'lname': lname,
      'role': role,
    };

    try {
      final bearerToken =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(bodyData),
      );

      final responseBody =
          response.body.isNotEmpty ? jsonDecode(response.body) : null;
      _logApiCall(functionName, bodyData, responseBody, response.statusCode);

      return response.statusCode == 200;
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()}, null);
      return false;
    }
  }
}
