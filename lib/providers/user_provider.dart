import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Keys for SharedPreferences
  static const String _keyName = 'user_name';
  static const String _keyEmail = 'user_email';
  static const String _keyDomain = 'user_domain';

  UserProvider() {
    _loadUserFromPrefs();
  }

  void setUser(UserModel user) {
    _user = user;
    _saveUserToPrefs();
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String email,
    required String careerDomain,
  }) {
    if (_user != null) {
      _user = _user!.copyWith(
        name: name,
        email: email,
        careerDomain: careerDomain,
      );
      _saveUserToPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveUserToPrefs() async {
    if (_user == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, _user!.name);
    await prefs.setString(_keyEmail, _user!.email);
    await prefs.setString(_keyDomain, _user!.careerDomain);
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);
    final domain = prefs.getString(_keyDomain);

    if (name != null && email != null) {
      _user = UserModel(
        id: '1', // Dummy ID
        name: name,
        email: email,
        careerDomain: domain ?? 'Software Development',
      );
      notifyListeners();
    }
  }

  /*
  --- FUTURE SCOPE & INTEGRATION ---
  1. Image Picker: Integrate 'image_picker' package to allow users to select profile photos.
  2. Backend Sync: Add API calls (e.g., using 'dio' or 'http') within updateProfile() to sync changes with a server.
  3. Profile Verification: Add a 'isVerified' field to UserModel and UI badges for verified accounts.
  4. AI Suggestions: Use an LLM API to suggest career domains based on user interests/skills.
  */
}
