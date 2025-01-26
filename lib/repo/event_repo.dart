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
import '../models/get_participants_model.dart';

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

      if (response.statusCode != 201 || response.statusCode != 200) {
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
        print("get event error : $errorMessage   $response");
        return [];
      }
    } on FormatException {
      return [];
    } catch (e) {
      print("get event error  exception : $e  ");

      return [];
    }
  }

  // New method to get participants
  static Future<GetParicipantsModel> getParticipants(String eventId) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl${ApiConstants.getParticipants}$eventId'), // Add getParticipants endpoint in ApiConstants
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        return getParicipantsModelFromJson(response.body);
      } else {
        print("get participants error : ${response.body}");
        // Return empty model if API call fails
        return GetParicipantsModel(
          eventId: eventId,
          players: [],
          jury: [],
          referees: [],
        );
      }
    } on FormatException {
      return GetParicipantsModel(
        eventId: eventId,
        players: [],
        jury: [],
        referees: [],
      );
    } catch (e) {
      print("get participants error : $e");
      return GetParicipantsModel(
        eventId: eventId,
        players: [],
        jury: [],
        referees: [],
      );
    }
  }

// New method to create a match/bout
  static Future<ApiResponse> createMatch({
    required BuildContext context,
    required String eventId,
    required String redCornerPlayerId,
    required String blueCornerPlayerId,
    required String cornerARefereeId,
    required String cornerBRefereeId,
    required String cornerCRefereeId,
  }) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    final key = "comptetion create";
    try {
      final response = await http.post(
        Uri.parse(
            '$baseUrl${ApiConstants.createMatch}'), // Add createMatch endpoint in ApiConstants
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode({
          'eventId': eventId,
          'redCornerPlayerId': redCornerPlayerId,
          'blueCornerPlayerId': blueCornerPlayerId,
          'CornerARefereeId': cornerARefereeId,
          'CornerBRefereeId': cornerBRefereeId,
          'CornerCRefereeId': cornerCRefereeId,
          'rounds': "3",
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ToastConfig.showSuccess(context, 'Match created successfully');

        print("$key created successfully ");
        return ApiResponse(
          success: true,
          message: 'Match created successfully',
          data: responseData,
        );
      } else {
        ToastConfig.showError(
            context, responseData['message'] ?? 'Failed to create match');
        print("$key create failed " + responseData['message']);

        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to create match',
        );
      }
    } catch (e) {
      print("$key create error exception $e ");
      ToastConfig.showError(context, 'Error creating match: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error creating match: ${e.toString()}',
      );
    }
  }
}
