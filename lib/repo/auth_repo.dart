import 'dart:developer';

import 'package:my_app/core/network.dart';

import '../config/constants/api_constants.dart';
import '../config/shared_prefs_config.dart';
import '../models/user_exist_model.dart';

class AuthRepository {
  void _logApiCall(
      String functionName, dynamic requestBody, dynamic responseBody) {
    log('''
=== API Call Log: $functionName ===
Request Body: $requestBody
Response Body: $responseBody
============================
''');
  }

  Future<Map<String, dynamic>?> logInUser({
    required String phone,
    required String password,
  }) async {
    const functionName = 'logInUser';
    final requestBody = {
      'phone': "91$phone",
      'password': password,
    };

    try {
      final response = await NetworkService.post(
        ApiConst.login,
        body: requestBody,
      );
      _logApiCall(functionName, requestBody, response);
      return response;
    } catch (e) {
      _logApiCall(functionName, requestBody, {'error': e.toString()});
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
      final response = await NetworkService.post(
        ApiConst.signUp,
        body: bodyData,
      );
      _logApiCall(functionName, bodyData, response);
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()});
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
      final response = await NetworkService.post(
        ApiConst.createParticipant,
        body: bodyData,
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      _logApiCall(functionName, bodyData, response);
      return true;
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()});
      return false;
    }
  }

  Future<UserExistModel?> checkUserExist({
    required String phone,
  }) async {
    const functionName = 'checkUserExist';
    final phoneWithCode = "91$phone";

    try {
      final response = await NetworkService.get(
        "${ApiConst.checkUserExist}$phoneWithCode",
      );
      _logApiCall(functionName, {'phone': phoneWithCode}, response);
      return UserExistModel.fromJson(response);
    } catch (e) {
      _logApiCall(
          functionName, {'phone': phoneWithCode}, {'error': e.toString()});
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
      final response = await NetworkService.post(
        ApiConst.addParticipantToEvent,
        body: bodyData,
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      _logApiCall(functionName, bodyData, response);
      return true;
    } catch (e) {
      _logApiCall(functionName, bodyData, {'error': e.toString()});
      return false;
    }
  }
}
