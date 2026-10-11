import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

class NetworkClient {
  NetworkClient({
    this.baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gravityflipgame.com',
    ),
    this.timeout = const Duration(seconds: 15),
    Map<String, String>? headers,
  }) : _headers = {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         ...?headers,
       };

  final String baseUrl;
  final Duration timeout;
  final Map<String, String> _headers;

  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final response = await _sendRequest(() => HttpClient().getUrl(uri));
    return _decodeResponse(response);
  }

  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final response = await _sendRequest(
      () => HttpClient().postUrl(uri),
      body: body,
    );
    return _decodeResponse(response);
  }

  Future<dynamic> put(
    String path, {
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final response = await _sendRequest(
      () => HttpClient().putUrl(uri),
      body: body,
    );
    return _decodeResponse(response);
  }

  Future<dynamic> delete(
    String path, {
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final response = await _sendRequest(
      () => HttpClient().deleteUrl(uri),
      body: body,
    );
    return _decodeResponse(response);
  }

  Uri _buildUri(String path, {Map<String, String>? queryParameters}) {
    final cleanPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$baseUrl$cleanPath');
    if (queryParameters == null || queryParameters.isEmpty) {
      return uri;
    }
    return uri.replace(queryParameters: queryParameters);
  }

  Future<HttpClientResponse> _sendRequest(
    Future<HttpClientRequest> Function() requestFactory, {
    Object? body,
  }) async {
    final client = HttpClient();
    final request = await requestFactory();

    for (final entry in _headers.entries) {
      request.headers.set(entry.key, entry.value);
    }

    if (body != null) {
      final byteData = body is String ? body : body.toString();
      request.headers.contentLength = byteData.length;
      request.write(byteData);
    }

    try {
      final response = await request.close().timeout(timeout);
      return response;
    } on TimeoutException {
      throw const SocketException('Network request timed out.');
    } on HttpException catch (error) {
      throw HttpException('HTTP error: $error');
    } finally {
      client.close(force: true);
    }
  }

  dynamic _decodeResponse(HttpClientResponse response) {
    if (kDebugMode) {
      debugPrint('Response status: ${response.statusCode}');
    }

    return response.statusCode >= 200 && response.statusCode < 300
        ? response
        : null;
  }
}
