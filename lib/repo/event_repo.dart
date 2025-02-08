import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/config/toast_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';

import '../models/competetion_model.dart';
import '../models/create_event_model.dart';
import '../models/event_resp_model.dart';
import '../models/get_participants_model.dart';
import '../models/round_analytics_model.dart';

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

  Future<ApiResponse> createMatch({
    required BuildContext context,
    required String eventId,
    required String redCornerPlayerId,
    required String blueCornerPlayerId,
    required String cornerARefereeId,
    required String cornerBRefereeId,
    required String cornerCRefereeId,
    required String redCornerPlayerName,
    required String blueCornerPlayerName,
    required String cornerARefereeName,
    required String cornerBRefereeName,
    required String cornerCRefereeName,
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
          "eventId": eventId,
          "redCornerPlayer": {
            "id": redCornerPlayerId,
            "name": redCornerPlayerName
          },
          "blueCornerPlayer": {
            "id": blueCornerPlayerId,
            "name": blueCornerPlayerName
          },
          "CornerAReferee": {
            "id": cornerARefereeId,
            "name": cornerARefereeName
          },
          "CornerBReferee": {
            "id": cornerBRefereeId,
            "name": cornerBRefereeName
          },
          "CornerCReferee": {
            "id": cornerCRefereeId,
            "name": cornerCRefereeName
          },
          "rounds": 3
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

  static Future<List<CompetetionModel>> getCompetitionDetails(
      String eventId) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1.0/competition-details?eventId=$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        return competetionModelFromJson(response.body);
      } else {
        print("get competition details error : ${response.body}");
        return [];
      }
    } catch (e) {
      print("get competition details error : $e");
      return [];
    }
  }

  static Future<ApiResponse> updateRoundStatus({
    required BuildContext context,
    required String competitionId,
    required int round,
    required int status,
  }) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    const key = "update round status";

    try {
      final queryParameters = {
        'competitionId': competitionId,
        'round': round.toString(),
        'status': status.toString(),
      };

      final response = await http.put(
        Uri.parse('$baseUrl${ApiConstants.updateRoundStatus}').replace(
          queryParameters: queryParameters,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ToastConfig.showSuccess(context, 'Round status updated successfully');
        print("$key updated successfully  resp ${response.body}");
        return ApiResponse(
          success: true,
          message: 'Round status updated successfully',
          data: responseData,
        );
      } else {
        ToastConfig.showError(context,
            responseData['message'] ?? 'Failed to update round status');
        print("$key update failed: ${responseData['message']}");
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to update round status',
        );
      }
    } catch (e) {
      print("$key update error exception: $e");
      ToastConfig.showError(
          context, 'Error updating round status: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error updating round status: ${e.toString()}',
      );
    }
  }

  static Future<RoundAnalyticsModel> getRoundAnalytics(
      {required BuildContext context,
      required String competitionId,
      required int round,
      required String position

      // String position = 'all',
      }) async {
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    const key = "get round details";

    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConstants.getRoundDetails}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode({
          'competitionId': competitionId,
          'round': round,
          'position': position,
        }),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response using the RoundAnalyticsModel
        return RoundAnalyticsModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = json.decode(response.body)['message'] ??
            'Failed to fetch round details';

        ToastConfig.showError(context, errorMessage);

        print("$key error: $errorMessage");

        // Return an empty model or throw an exception based on your error handling strategy
        return RoundAnalyticsModel(roundedScores: []);
      }
    } catch (e) {
      print("$key error exception: $e");

      ToastConfig.showError(
          context, 'Error fetching round details: ${e.toString()}');

      // Return an empty model or throw an exception based on your error handling strategy
      return RoundAnalyticsModel(roundedScores: []);
    }
  }
}
