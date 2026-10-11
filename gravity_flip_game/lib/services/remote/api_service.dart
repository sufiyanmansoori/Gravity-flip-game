import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiError implements Exception {
  const ApiError(this.message, {this.statusCode, this.responseBody});

  final String message;
  final int? statusCode;
  final String? responseBody;

  @override
  String toString() => 'ApiError(statusCode: $statusCode, message: $message)';
}

class ApiService {
  ApiService({
    required this._baseUrl,
    Map<String, String>? defaultHeaders,
    this._timeout = const Duration(seconds: 15),
  }) : _defaultHeaders = {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         ...?defaultHeaders,
       };

  final String _baseUrl;
  final Map<String, String> _defaultHeaders;
  final Duration _timeout;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await http
        .get(_buildUri(path, queryParameters), headers: _mergedHeaders(headers))
        .timeout(_timeout);

    return _decodeJson(response, expectedStatus: 200);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await http
        .post(
          _buildUri(path),
          headers: _mergedHeaders(headers),
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);

    return _decodeJson(response, expectedStatus: 200);
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await http
        .put(
          _buildUri(path),
          headers: _mergedHeaders(headers),
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);

    return _decodeJson(response, expectedStatus: 200);
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await http
        .delete(
          _buildUri(path),
          headers: _mergedHeaders(headers),
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);

    return _decodeJson(response, expectedStatus: 200);
  }

  Uri _buildUri(String path, [Map<String, String>? queryParameters]) {
    final uri = Uri.parse('$_baseUrl${path.startsWith('/') ? path : '/$path'}');
    if (queryParameters == null || queryParameters.isEmpty) {
      return uri;
    }
    return uri.replace(
      queryParameters: {...uri.queryParameters, ...queryParameters},
    );
  }

  Map<String, String> _mergedHeaders(Map<String, String>? headers) {
    return {..._defaultHeaders, ...?headers};
  }

  Map<String, dynamic> _decodeJson(
    http.Response response, {
    required int expectedStatus,
  }) {
    if (response.statusCode != expectedStatus) {
      throw ApiError(
        'Request failed with status ${response.statusCode}',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      throw ApiError(
        'Unexpected response format',
        statusCode: response.statusCode,
      );
    } on FormatException {
      throw ApiError(
        'Response is not valid JSON',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }
}
