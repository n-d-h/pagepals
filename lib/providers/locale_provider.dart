import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
  late SharedPreferences _prefs;

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleProvider() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    // Retrieve the selected language from SharedPreferences
    var localeLanguageCode = _prefs.getString('locale');
    if (localeLanguageCode != null) {
      var locale = jsonDecode(localeLanguageCode);
      _locale = Locale(locale);
    }
  }

  void setLocale(Locale locale) {
    _locale = locale;
    // Store the selected language in SharedPreferences
    var localeLanguageCode = jsonEncode(_locale.languageCode);
    _prefs.setString('locale', localeLanguageCode);
    notifyListeners();
  }
}
