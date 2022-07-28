import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lang/en_us.dart';
import '../lang/fa_ir.dart';
import 'service_locator.dart';

class LocalizationService extends Translations {
  LocalizationService(String initLang) {
    locale = _getLocale(initLang);
    _changeFontFamily(initLang);
  }

  late final Locale locale;

  static const fallBackLocale = Locale('fa', 'IR');

  static String? fontFamily;

  static final langs = [
    'فارسی',
    'English',
  ];

  static const locales = [
    Locale('fa', 'IR'),
    Locale('en', 'US'),
  ];

  static const fontFamilies = [
    'Peyda',
    'Roboto'
  ];

  @override
  Map<String, Map<String, String>> get keys => {'fa_IR': faIR, 'en_US': enUS};

  static void changeLocale(String localeName) {
    sharedPreferences.setString('language', localeName);
    final locale = _getLocale(localeName);
    _changeFontFamily(localeName);
    Get.updateLocale(locale);
  }

  static void _changeFontFamily(String localeName) {
    try {
      fontFamily = fontFamilies[langs.indexOf(localeName)];
    } catch (e) {
      fontFamily = fontFamilies[0];
    }
  }

  static Locale _getLocale(String lang) {
    try {
      return locales[langs.indexOf(lang)];
    } catch (e) {
      return locales[0];
    }
  }
}
