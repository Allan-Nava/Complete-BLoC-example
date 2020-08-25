import 'package:flutter/material.dart';
import 'package:flutter_app/repository/user_repository.dart';

/// Registration and authentication mock
class TestUserRepository extends UserRepository {
  final String fakeEmail;
  final bool success;
  const TestUserRepository({
    @required this.fakeEmail,
    @required this.success,
  });

  @override
  Future<bool> authenticate(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => success);
  }

  @override
  Future<bool> register(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => success);
  }

  @override
  Future<void> logOut() => Future.delayed(const Duration(milliseconds: 200));

  @override
  String get signedEmail => fakeEmail;
}