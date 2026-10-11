import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ScoreRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchLeaderboard();
}

class ScoreRemoteDataSourceImpl implements ScoreRemoteDataSource {
  ScoreRemoteDataSourceImpl({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
    const url = 'https://example.com/api/leaderboard';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map((entry) => Map<String, dynamic>.from(entry as Map))
        .toList();
  }
}
