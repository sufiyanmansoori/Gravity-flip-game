part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested({
    required this.email,
    required this.username,
    required this.password,
    required this.displayName,
  });

  final String email;
  final String username;
  final String password;
  final String displayName;
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
