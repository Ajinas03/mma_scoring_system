import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/constants/api_constants.dart';
import '../config/shared_prefs_config.dart';

class NetworkService {
  static String baseUrl = ApiConst.baseUrl;

  // List of endpoints that don't require authentication
  static final List<String> _publicEndpoints = [
    ApiConst.login,
    ApiConst.signUp,
    ApiConst.checkUserExist,
  ];

  static Map<String, String> _getHeaders({
    Map<String, String>? additionalHeaders,
    bool requiresAuth = true,
  }) {
    // Base headers that are always included
    final baseHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add bearer token for authenticated endpoints
    if (requiresAuth) {
      final bearerToken =
          SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken);
      if (bearerToken.isEmpty) {
        throw Exception('Bearer token required but not found');
      }
      baseHeaders['Authorization'] = 'Bearer $bearerToken';
    }

    // Add any additional headers
    if (additionalHeaders != null) {
      baseHeaders.addAll(additionalHeaders);
    }

    return baseHeaders;
  }

  static void _logRequest(
      String method, Uri uri, Map<String, String> headers, dynamic body) {
    print('┌─────────────── $method REQUEST ───────────────');
    print('│ URL: $uri');
    print('│ Headers: $headers');
    if (body != null) {
      print('│ Request Body: $body');
    }
    print('└────────────────────────────────────────\n');
  }

  static void _logResponse(http.Response response) {
    print('┌─────────────── RESPONSE ───────────────');
    print('│ Status Code: ${response.statusCode}');
    print('│ Response Headers: ${response.headers}');
    print('│ Response Body: ${response.body}');
    print('└────────────────────────────────────────\n');
  }

  static void _logError(String error) {
    print('┌─────────────── ERROR ───────────────');
    print('│ Error: $error');
    print('└────────────────────────────────────────\n');
  }

  static Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    bool? requiresAuth,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters:
            queryParams?.map((key, value) => MapEntry(key, value.toString())),
      );

      // If requiresAuth is not specified, check if the endpoint is public
      final needsAuth = requiresAuth ?? !_publicEndpoints.contains(endpoint);

      final finalHeaders = _getHeaders(
        additionalHeaders: headers,
        requiresAuth: needsAuth,
      );
      _logRequest('GET', uri, finalHeaders, null);

      final response = await http.get(uri, headers: finalHeaders);
      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) return null;
        return json.decode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      _logError(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    bool? requiresAuth,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters:
            queryParams?.map((key, value) => MapEntry(key, value.toString())),
      );

      // If requiresAuth is not specified, check if the endpoint is public
      final needsAuth = requiresAuth ?? !_publicEndpoints.contains(endpoint);

      final finalHeaders = _getHeaders(
        additionalHeaders: headers,
        requiresAuth: needsAuth,
      );
      final encodedBody = body != null ? json.encode(body) : null;

      _logRequest('POST', uri, finalHeaders, body);

      final response = await http.post(
        uri,
        headers: finalHeaders,
        body: encodedBody,
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) return null;
        return json.decode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      _logError(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    bool? requiresAuth,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters:
            queryParams?.map((key, value) => MapEntry(key, value.toString())),
      );

      // If requiresAuth is not specified, check if the endpoint is public
      final needsAuth = requiresAuth ?? !_publicEndpoints.contains(endpoint);

      final finalHeaders = _getHeaders(
        additionalHeaders: headers,
        requiresAuth: needsAuth,
      );
      final encodedBody = body != null ? json.encode(body) : null;

      _logRequest('PUT', uri, finalHeaders, body);

      final response = await http.put(
        uri,
        headers: finalHeaders,
        body: encodedBody,
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) return null;
        return json.decode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      _logError(e.toString());
      throw Exception(e.toString());
    }
  }
}
