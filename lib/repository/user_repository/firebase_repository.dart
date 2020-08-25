import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/repository/user_repository.dart';

/// Registration and authentication mock
class FirebaseUserRepository extends UserRepository {
  const FirebaseUserRepository();

  @override
  /// Email of the signed user
  String get signedEmail {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.email;
    } else {
      return "";
    }
  }

  @override
  /// Authentication on Firebase with username and password
  Future<bool> authenticate(String username, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  /// Registration on Firebase with username and password
  Future<bool> register(String username, String password) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  /// Logout from Firebase
  Future<void> logOut() => FirebaseAuth.instance.signOut();
}