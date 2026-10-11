import 'dart:convert';

import 'package:http/http.dart' as http;

class GraphQLClient {
  GraphQLClient({
    required this._endpoint,
    Map<String, String>? headers,
    this._timeout = const Duration(seconds: 15),
  }) : _headers = {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
         ...?headers,
       };

  final String _endpoint;
  final Map<String, String> _headers;
  final Duration _timeout;

  Future<Map<String, dynamic>> query(
    String operation, {
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    return _send(
      operation: operation,
      variables: variables ?? const <String, dynamic>{},
      headers: headers,
    );
  }

  Future<Map<String, dynamic>> mutate(
    String operation, {
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    return _send(
      operation: operation,
      variables: variables ?? const <String, dynamic>{},
      headers: headers,
      operationType: 'mutation',
    );
  }

  Future<Map<String, dynamic>> _send({
    required String operation,
    required Map<String, dynamic> variables,
    Map<String, String>? headers,
    String operationType = 'query',
  }) async {
    final response = await http
        .post(
          Uri.parse(_endpoint),
          headers: {..._headers, ...?headers},
          body: jsonEncode({
            'query': _buildQuery(operation, operationType),
            'variables': variables,
          }),
        )
        .timeout(_timeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GraphQLException(
        'GraphQL request failed: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const GraphQLException('Malformed GraphQL response');
    }

    if (decoded.containsKey('errors')) {
      throw GraphQLException(
        decoded['errors'] is List
            ? decoded['errors']
                  .map((item) => item['message']?.toString() ?? 'Unknown error')
                  .join(', ')
            : 'GraphQL request returned errors',
      );
    }

    return decoded;
  }

  String _buildQuery(String operation, String operationType) {
    final cleanedOperation = operation.trim();
    if (cleanedOperation.isEmpty) {
      throw ArgumentError.value(operation, 'operation', 'cannot be empty');
    }

    return '$operationType $cleanedOperation';
  }
}

class GraphQLException implements Exception {
  const GraphQLException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'GraphQLException(statusCode: $statusCode, message: $message)';
}
