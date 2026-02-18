import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _currentUser;

  AuthService() {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _currentUser = UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? user.email?.split('@')[0] ?? 'User',
        );
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  bool get isAuthenticated => _auth.currentUser != null;
  UserModel? get currentUser => _currentUser;

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name
      await result.user?.updateDisplayName(name);

      // Update local current user
      _currentUser = UserModel(id: result.user!.uid, email: email, name: name);

      notifyListeners();
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
