import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageConfigModel extends ChangeNotifier {
  LanguageConfigModel() {
    _loadCurrentLanguage();
  }
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    _currentLocale = Locale(languageCode);

    notifyListeners();
  }

  void changeLanguage(Locale locale) {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    // _saveLanguage(locale);
    notifyListeners();
  }

  Future<void> _saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }
}
