import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void changeTheme(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}