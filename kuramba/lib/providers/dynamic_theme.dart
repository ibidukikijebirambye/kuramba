import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/themes.dart' as themes;

enum ThemeColor {
  green,
}

class DynamicTheme with ChangeNotifier {
  ThemeColor _currentThemeColor = ThemeColor.green;
  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeColor get currentThemeColor {
    return ThemeColor.values[_currentThemeColor.index];
  }

  ThemeMode get currentThemeMode {
    return ThemeMode.values[_currentThemeMode.index];
  }

  List<Map<String, dynamic>> get availableThemeColors {
    return [
      {
        'name': 'Green',
        'value': ThemeColor.green,
      },
    ];
  }

  List<Map<String, dynamic>> get availableThemeModes {
    return [
      {
        'name': 'System',
        'value': ThemeMode.system,
      },
      {
        'name': 'Light',
        'value': ThemeMode.light,
      },
      {
        'name': 'Dark',
        'value': ThemeMode.dark,
      },
    ];
  }

  void setThemeColor(ThemeColor themeColor) async {
    _currentThemeColor = themeColor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeColor', themeColor.index);
  }

  void setThemeMode(ThemeMode themeMode) async {
    _currentThemeMode = themeMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
  }

  Future<void> fetchThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('themeColor')) {
      _currentThemeColor = ThemeColor.values[prefs.getInt('themeColor')];
    }
    if (prefs.containsKey('themeMode')) {
      _currentThemeMode = ThemeMode.values[prefs.getInt('themeMode')];
    }
  }

  ThemeData get theme {
    switch (_currentThemeColor) {
      case ThemeColor.green:
        return themes.greenTheme;
        break;
      default:
        return themes.greenTheme;
        break;
    }
  }

  ThemeData get darkTheme {
    switch (_currentThemeColor) {
      case ThemeColor.green:
        return themes.greenDarkTheme;
        break;
      default:
        return themes.greenDarkTheme;
        break;
    }
  }
}
