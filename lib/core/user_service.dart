import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;

  const UserModel({
    required this.name,
    required this.email,
    this.phone = '',
  });

  String get initials {
    final clean = name.trim();
    if (clean.isEmpty) return 'U';
    final parts = clean.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Reactive user state
  static final ValueNotifier<UserModel> currentUserNotifier =
      ValueNotifier<UserModel>(
    const UserModel(
      name: 'ReuseIt User',
      email: 'user@reuseit.com',
    ),
  );

  static UserModel get currentUser => currentUserNotifier.value;

  /// Log in and parse user's name & email intelligently from login input
  static void loginWithInput(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return;

    String name;
    String email;
    String phone = '';

    if (trimmed.contains('@')) {
      // Input is an email (e.g. amina.khan@gmail.com)
      email = trimmed;
      final localPart = trimmed.split('@').first;
      // Convert 'amina.khan' or 'amina_khan' -> 'Amina Khan'
      final words = localPart
          .replaceAll(RegExp(r'[^a-zA-Z]'), ' ')
          .trim()
          .split(RegExp(r'\s+'))
          .where((w) => w.isNotEmpty)
          .toList();

      if (words.isNotEmpty) {
        name = words.map((w) {
          return w[0].toUpperCase() + (w.length > 1 ? w.substring(1).toLowerCase() : '');
        }).join(' ');
      } else {
        name = 'ReuseIt User';
      }
    } else if (RegExp(r'^[0-9+\s()-]+$').hasMatch(trimmed) && trimmed.length >= 7) {
      // Input is a phone number
      phone = trimmed;
      final digits = trimmed.replaceAll(RegExp(r'\D'), '');
      final last4 = digits.length >= 4 ? digits.substring(digits.length - 4) : digits;
      name = 'User $last4';
      email = 'user$last4@reuseit.com';
    } else {
      // Input is a direct Name (e.g. "Amina Khan" or "Hamza")
      name = trimmed;
      final clean = trimmed
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]'), '.')
          .replaceAll(RegExp(r'\.+'), '.');
      email = '$clean@reuseit.com';
    }

    currentUserNotifier.value = UserModel(
      name: name,
      email: email,
      phone: phone,
    );
  }

  /// Update user details directly from profile editing
  static void updateProfile({
    required String name,
    required String email,
    String phone = '',
  }) {
    currentUserNotifier.value = UserModel(
      name: name.trim().isEmpty ? 'ReuseIt User' : name.trim(),
      email: email.trim().isEmpty ? 'user@reuseit.com' : email.trim(),
      phone: phone.trim(),
    );
  }

  /// Logout and reset
  static void logout() {
    currentUserNotifier.value = const UserModel(
      name: 'ReuseIt User',
      email: 'user@reuseit.com',
    );
  }
}
