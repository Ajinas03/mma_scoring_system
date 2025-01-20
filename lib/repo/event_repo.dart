import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/config/toast_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';

import '../models/create_event_model.dart';
import '../models/event_resp_model.dart';

class EventRepo {
  static const String baseUrl = ApiConstants.baseUrl;

  // Event creation model

  static Future<ApiResponse> createEvent({
    required BuildContext context,
    required CreateEventRequest event,
  }) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConstants.createEvent}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(event.toJson()),
      );

      // Parse response
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201) {
        ToastConfig.showSuccess(
            context, responseData['message'] ?? 'Failed to create event');

        context.read<EventBloc>().add(GetEvent());
        Navigator.pop(context);
        return ApiResponse(
          success: true,
          message: 'Event created successfully',
          data: responseData,
        );
      } else {
        ToastConfig.showSuccess(context, 'Event created successfully');
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to create event',
        );
      }
    } catch (e) {
      ToastConfig.showError(context, 'Error creating event: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error creating event: ${e.toString()}',
      );
    }
  }

  static Future<List<EventRespModel>> getEvents() async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ApiConstants.getEvents),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        return eventRespModelFromJson(response.body);
      } else {
        final errorMessage =
            json.decode(response.body)['message'] ?? 'Failed to fetch events';
        throw Exception(errorMessage);
      }
    } on FormatException {
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Error fetching events: ${e.toString()}');
    }
  }
}
