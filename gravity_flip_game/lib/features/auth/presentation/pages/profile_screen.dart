import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        user ??
        UserEntity(
          id: 'guest',
          email: 'guest@gravityflip.com',
          username: 'Guest',
          displayName: 'Guest Player',
          bio: 'Guest player',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const LogoutRequested()),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.amber,
                  child: Text(
                    currentUser.displayName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  currentUser.displayName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  '@${currentUser.username}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 30),
              _InfoTile(label: 'Email', value: currentUser.email),
              _InfoTile(
                label: 'Bio',
                value: currentUser.bio.isEmpty ? 'No bio yet' : currentUser.bio,
              ),
              _InfoTile(
                label: 'Member since',
                value: currentUser.createdAt
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),
              _InfoTile(
                label: 'Last login',
                value: currentUser.lastLoginAt != null
                    ? currentUser.lastLoginAt!
                          .toLocal()
                          .toString()
                          .split(' ')
                          .first
                    : 'Not available',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
