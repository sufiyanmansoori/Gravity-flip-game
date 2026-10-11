class ErrorInterceptor {
  const ErrorInterceptor();

  Exception handle(int statusCode, dynamic body) {
    switch (statusCode) {
      case 400:
        return const FormatException('Bad request.');
      case 401:
        return const FormatException('Unauthorized.');
      case 403:
        return const FormatException('Forbidden.');
      case 404:
        return const FormatException('Resource not found.');
      case 429:
        return const FormatException('Too many requests.');
      case 500:
      case 502:
      case 503:
      case 504:
        return const FormatException('Server temporarily unavailable.');
      default:
        return FormatException('Unexpected error: ${body ?? 'unknown'}');
    }
  }
}
