import 'package:attend_pro/core/theme/apptheme.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  ThemeData themeData = AppTheme().lightTheme;
  Future<void> changeTheme(ThemeData themeData) async {
    this.themeData = themeData;
    notifyListeners();
  }
}
