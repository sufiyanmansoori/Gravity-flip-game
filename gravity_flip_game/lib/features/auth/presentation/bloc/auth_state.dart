part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object?> get props => const [];
}

class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object?> get props => const [];
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({required this.user, required this.token});

  final UserEntity user;
  final String token;

  @override
  List<Object?> get props => [user, token];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();

  @override
  List<Object?> get props => const [];
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
