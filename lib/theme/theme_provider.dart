import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_preference';

  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get currentTheme => _currentTheme;

  bool get isDarkMode => _currentTheme == ThemeMode.dark;

  ThemeProvider() {
    loadTheme();
  }

  // Toggle between Light and Dark
  Future<void> toggleTheme(bool isDark) async {
    _currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, isDark ? 1 : 0);
  }

  // Load theme preference from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex != null) {
      _currentTheme = themeIndex == 1 ? ThemeMode.dark : ThemeMode.light;
    } else {
      _currentTheme = ThemeMode.system;
    }
    notifyListeners();
  }
}
