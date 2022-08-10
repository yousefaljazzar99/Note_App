import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class DarkMode extends ChangeNotifier {
  bool isDark = false;

  changeTheme(bool value) {
    isDark = value;
    notifyListeners();
  }

  changeLanguage(context) {
    if (context.locale.toString() == 'ar') {
      context.setLocale(Locale('en'));
    } else {
      context.setLocale(Locale('ar'));
    }
  }
}
