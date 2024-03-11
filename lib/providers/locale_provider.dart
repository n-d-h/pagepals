import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
  late SharedPreferences _prefs;

  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  LocaleProvider() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setLocale(Locale locale) {
    var localeLanguageCode = _prefs.getString('locale');
    if (localeLanguageCode != null) {
      var locale = jsonDecode(localeLanguageCode);
      _locale = Locale(locale);
    } else {
      _locale = locale;
      localeLanguageCode = jsonEncode(_locale.languageCode);
      _prefs.setString('locale', localeLanguageCode);
    }
    notifyListeners();
  }
}