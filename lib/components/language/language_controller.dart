import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController._();
  LanguageController._();

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('pl');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}