import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  const AuthModel({
    required this.token,
    required this.expiresAt,
    required this.user,
  });

  final String token;
  final DateTime expiresAt;
  final Map<String, dynamic> user;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String? ?? '',
      expiresAt:
          DateTime.tryParse(
            json['expiresAt'] as String? ?? DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
      user: Map<String, dynamic>.from(
        json['user'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiresAt': expiresAt.toIso8601String(),
      'user': user,
    };
  }

  @override
  List<Object?> get props => [token, expiresAt, user];
}
