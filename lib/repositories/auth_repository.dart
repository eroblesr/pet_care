import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:user_repository/src/firebase_user_repository.dart';
import 'package:user_repository/user_repository.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<User> signup({
    required String email,
    required String phoneNumber,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user?.toUser ?? User.empty;
      return user.copyWith(name: name, phoneNumber: phoneNumber);
    } catch (error) {
      debugPrint(error.toString());
    }
    return User.empty;
  }

  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    {
      try {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        final user = userCredential.user?.toUser ?? User.empty;
        return user;
      } catch (error) {
        debugPrint(error.toString());
      }
      return User.empty;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid,
        name: displayName ?? '',
        phoneNumber: '',
        location: '',
        photoUrl: photoURL ?? '');
  }
}
