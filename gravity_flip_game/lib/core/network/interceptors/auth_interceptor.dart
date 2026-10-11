class AuthInterceptor {
  const AuthInterceptor({this.token});

  final String? token;

  Map<String, String> apply(Map<String, String> headers) {
    if (token == null || token!.isEmpty) {
      return headers;
    }

    return {...headers, 'Authorization': 'Bearer $token'};
  }
}
