import 'dart:convert';

import 'package:http/http.dart' as http;

class RestClient {
  RestClient({
    this._baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gravityflipgame.com',
    ),
    Map<String, String>? headers,
    this._timeout = const Duration(seconds: 15),
  }) : _headers = {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         ...?headers,
       };

  final String _baseUrl;
  final Map<String, String> _headers;
  final Duration _timeout;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final uri = _buildUri(path, query: query);
    final response = await http.get(uri, headers: _headers).timeout(_timeout);
    return _handle(response);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(path);
    final response = await http
        .post(
          uri,
          headers: _headers,
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);
    return _handle(response);
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(path);
    final response = await http
        .patch(
          uri,
          headers: _headers,
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);
    return _handle(response);
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(path);
    final response = await http
        .delete(
          uri,
          headers: _headers,
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(_timeout);
    return _handle(response);
  }

  Uri _buildUri(String path, {Map<String, dynamic>? query}) {
    final base = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$base$normalizedPath');

    if (query == null || query.isEmpty) {
      return uri;
    }

    return uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        ...query.map((key, value) => MapEntry(key, value.toString())),
      },
    );
  }

  Map<String, dynamic> _handle(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Request failed (${response.statusCode}): ${response.body}',
        statusCode: response.statusCode,
      );
    }

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return Map<String, dynamic>.from(decoded);
    }
    throw const FormatException('REST API response must be a JSON object.');
  }
}

class HttpException implements Exception {
  const HttpException(this.message, {required this.statusCode});

  final String message;
  final int statusCode;

  @override
  String toString() =>
      'HttpException(statusCode: $statusCode, message: $message)';
}
