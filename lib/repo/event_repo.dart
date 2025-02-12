import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/config/constants/api_constants.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/config/toast_config.dart';
import 'package:my_app/logic/event/event_bloc.dart';

import '../models/all_round_analytics_model.dart';
import '../models/competetion_model.dart';
import '../models/create_event_model.dart';
import '../models/event_resp_model.dart';
import '../models/get_participants_model.dart';
import '../models/round_analytics_model.dart';

class EventRepo {
  static const String baseUrl = ApiConst.baseUrl;

  static Future<ApiResponse> createEvent({
    required BuildContext context,
    required CreateEventRequest event,
  }) async {
    const key = "createEvent";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConst.createEvent}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(event.toJson()),
      );

      log("$key response: ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201 || response.statusCode != 200) {
        log("$key success: created event");
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
        log("$key error: failed to create event");
        ToastConfig.showSuccess(context, 'Event created successfully');
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to create event',
        );
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      ToastConfig.showError(context, 'Error creating event: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error creating event: ${e.toString()}',
      );
    }
  }

  static Future<List<EventRespModel>> getEvents() async {
    const key = "getEvents";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ApiConst.getEvents),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      log("$key response: ${response.body}   : bearer tokennn $bearerToken");

      if (response.statusCode == 200) {
        log("$key success: fetched events");
        return eventRespModelFromJson(response.body);
      } else {
        final errorMessage =
            json.decode(response.body)['message'] ?? 'Failed to fetch events';
        log("$key error: $errorMessage");
        return [];
      }
    } on FormatException {
      log("$key error: FormatException");
      return [];
    } catch (e) {
      log("$key error: ${e.toString()}");
      return [];
    }
  }

  static Future<GetParicipantsModel> getParticipants(String eventId) async {
    const key = "getParticipants";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConst.getParticipants}$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      log("$key response: ${response.body}");

      if (response.statusCode == 200) {
        log("$key success: fetched participants");
        return getParicipantsModelFromJson(response.body);
      } else {
        log("$key error: ${response.body}");
        return GetParicipantsModel(
          eventId: eventId,
          players: [],
          jury: [],
          referees: [],
        );
      }
    } on FormatException {
      log("$key error: FormatException");
      return GetParicipantsModel(
        eventId: eventId,
        players: [],
        jury: [],
        referees: [],
      );
    } catch (e) {
      log("$key error: ${e.toString()}");
      return GetParicipantsModel(
        eventId: eventId,
        players: [],
        jury: [],
        referees: [],
      );
    }
  }

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
    const key = "createMatch";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConst.createMatch}'),
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

      log("$key response: ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("$key success: match created");
        ToastConfig.showSuccess(context, 'Match created successfully');
        return ApiResponse(
          success: true,
          message: 'Match created successfully',
          data: responseData,
        );
      } else {
        log("$key error: ${responseData['message']}");
        ToastConfig.showError(
            context, responseData['message'] ?? 'Failed to create match');
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to create match',
        );
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      ToastConfig.showError(context, 'Error creating match: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error creating match: ${e.toString()}',
      );
    }
  }

  static Future<List<CompetetionModel>> getCompetitionDetails(
      String eventId) async {
    const key = "getCompetitionDetails";
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

      log("$key response: ${response.body}");

      if (response.statusCode == 200) {
        log("$key success: fetched competition details");
        return competetionModelFromJson(response.body);
      } else {
        log("$key error: ${response.body}");
        return [];
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      return [];
    }
  }

  static Future<ApiResponse> updateRoundStatus({
    required BuildContext context,
    required String competitionId,
    required int round,
    required int status,
  }) async {
    const key = "updateRoundStatus";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);

    try {
      final queryParameters = {
        'competitionId': competitionId,
        'round': round.toString(),
        'status': status.toString(),
      };

      final response = await http.put(
        Uri.parse('$baseUrl${ApiConst.updateRoundStatus}').replace(
          queryParameters: queryParameters,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      log("$key response: ${response.body}");
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("$key success: round status updated");
        ToastConfig.showSuccess(context, 'Round status updated successfully');
        return ApiResponse(
          success: true,
          message: 'Round status updated successfully',
          data: responseData,
        );
      } else {
        log("$key error: ${responseData['message']}");
        ToastConfig.showError(context,
            responseData['message'] ?? 'Failed to update round status');
        return ApiResponse(
          success: false,
          message: responseData['message'] ?? 'Failed to update round status',
        );
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      ToastConfig.showError(
          context, 'Error updating round status: ${e.toString()}');
      return ApiResponse(
        success: false,
        message: 'Error updating round status: ${e.toString()}',
      );
    }
  }

  static Future<RoundAnalyticsModel> getRoundAnalytics({
    required BuildContext context,
    required String competitionId,
    required int round,
    required String position,
  }) async {
    const key = "getRoundAnalytics";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConst.getRoundDetails}'),
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

      log("$key response: ${response.body}  , body  :: ${jsonEncode({
            'competitionId': competitionId,
            'round': round,
            'position': position,
          })}");

      if (response.statusCode == 200) {
        log("$key success: fetched round analytics");
        return RoundAnalyticsModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = json.decode(response.body)['message'] ??
            'Failed to fetch round details';
        log("$key error: $errorMessage");
        ToastConfig.showError(context, errorMessage);
        return RoundAnalyticsModel(roundedScores: []);
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      ToastConfig.showError(
          context, 'Error fetching round details: ${e.toString()}');
      return RoundAnalyticsModel(roundedScores: []);
    }
  }

  static Future<AllRoundAnalytics> getAllRoundAnalytics({
    required BuildContext context,
    required String competitionId,
    required int round,
  }) async {
    const key = "getAllRoundAnalytics";
    final bearerToken =
        SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConst.getRoundDetails}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode({
          'competitionId': competitionId,
          'round': round,
          'position': 'all',
        }),
      );

      log("$key response: ${response.body}");

      if (response.statusCode == 200) {
        log("$key success: fetched all round analytics");
        return allRoundAnalyticsFromJson(response.body);
      } else {
        final errorMessage = json.decode(response.body)['message'] ??
            'Failed to fetch round details';
        log("$key error: $errorMessage");
        ToastConfig.showError(context, errorMessage);
        return AllRoundAnalytics(roundsDetails: []);
      }
    } catch (e) {
      log("$key error: ${e.toString()}");
      ToastConfig.showError(
          context, 'Error fetching round details: ${e.toString()}');
      return AllRoundAnalytics(roundsDetails: []);
    }
  }
}
