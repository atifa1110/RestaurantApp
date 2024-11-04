import 'package:flutter/material.dart';
import '../data/preferences/preferences_helper.dart';
import '../theme/app_theme.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getThemePreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;


  ThemeData get themeData => _isDarkTheme ? AppThemes.darkTheme : AppThemes.lightTheme;

  void _getThemePreferences() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void setDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getThemePreferences();
  }

}