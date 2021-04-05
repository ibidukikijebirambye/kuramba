import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeColor {
  green,
}

class ThemeProvider with ChangeNotifier {
  final _greenTheme = ThemeData(
    //General
    brightness: Brightness.light,
    primaryColor: Colors.green,
    accentColor: Colors.green[900],
    errorColor: Colors.red,
    shadowColor: Colors.grey[300],
    //Text
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      bodyText2: TextStyle(
        color: Colors.grey[600],
        height: 1.5,
      ),
    ),
    //Divider
    dividerTheme: DividerThemeData(
      color: Colors.grey[600],
    ),
    //Dialog
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
      ),
    ),
    //Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    //Card
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
    ),
    //AppBar
    appBarTheme: AppBarTheme(
      elevation: 5,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline6: GoogleFonts.montserrat().copyWith(
          fontSize: 20,
        ),
      ),
    ),
    //Scaffold
    scaffoldBackgroundColor: Colors.white,
    //BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.green,
      selectedItemColor: Colors.green[900],
      unselectedItemColor: Colors.white,
      showUnselectedLabels: false,
    ),
  );

  final _greenDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
    accentColor: Colors.green[900],
    errorColor: Colors.red,
    shadowColor: Colors.grey[900],
    //Dialog
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
      ),
    ),
    //Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.green[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    //Card
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
    ),
    //AppBar
    appBarTheme: AppBarTheme(
      elevation: 5,
      textTheme: TextTheme(
        headline6: GoogleFonts.montserrat().copyWith(
          fontSize: 20,
        ),
      ),
    ),
    //BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.green[700],
      selectedItemColor: Colors.green[900],
      unselectedItemColor: Colors.white,
      showUnselectedLabels: false,
    ),
  );

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
        return _greenTheme;
        break;
      default:
        return _greenTheme;
        break;
    }
  }

  ThemeData get darkTheme {
    switch (_currentThemeColor) {
      case ThemeColor.green:
        return _greenDarkTheme;
        break;
      default:
        return _greenDarkTheme;
        break;
    }
  }
}
