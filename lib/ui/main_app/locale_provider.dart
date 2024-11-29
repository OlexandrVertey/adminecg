import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {

  Locale? appLocale;

  // Locale? get locale => _locale;

  void setLocale(Locale locale) async {
    appLocale = locale;
    notifyListeners();
  }
}