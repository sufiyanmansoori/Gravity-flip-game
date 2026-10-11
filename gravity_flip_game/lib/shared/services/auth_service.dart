import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  AuthService();

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userId;
  String? _sessionToken;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;
  String? get sessionToken => _sessionToken;

  Future<void> signIn({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (email.trim().isEmpty || password.trim().length < 6) {
        throw Exception('Invalid credentials.');
      }

      _userId = email.trim();
      _sessionToken = 'session_${DateTime.now().millisecondsSinceEpoch}';
      _isAuthenticated = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _isAuthenticated = false;
      _userId = null;
      _sessionToken = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void restoreSession({String? userId, String? token}) {
    _userId = userId;
    _sessionToken = token;
    _isAuthenticated = userId != null && token != null;
    notifyListeners();
  }
}
