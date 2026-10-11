import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this._loginUseCase,
    required this._registerUseCase,
    required this._logoutUseCase,
    required this._getCurrentUserUseCase,
  }) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _getCurrentUserUseCase();
      if (user == null) {
        emit(const AuthUnauthenticated());
        return;
      }

      emit(AuthAuthenticated(user: user, token: 'session_token'));
    } catch (error) {
      emit(AuthFailure('Failed to restore session: $error'));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await _loginUseCase(
        email: event.email,
        password: event.password,
      );

      emit(AuthAuthenticated(user: result.user, token: result.token));
    } catch (error) {
      emit(AuthFailure('Login failed: $error'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await _registerUseCase(
        email: event.email,
        username: event.username,
        password: event.password,
        displayName: event.displayName,
      );

      emit(AuthAuthenticated(user: result.user, token: result.token));
    } catch (error) {
      emit(AuthFailure('Registration failed: $error'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _logoutUseCase();
      emit(const AuthUnauthenticated());
    } catch (error) {
      emit(AuthFailure('Logout failed: $error'));
    }
  }
}
