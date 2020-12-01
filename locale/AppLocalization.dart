import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class AppLocalization {
  
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get langSetting {
    return Intl.message(
      'Language Settings',
      name: 'langSetting',
    );
  }

  String get langZH{
    return Intl.message(
      'Chinese',
      name: 'langZH',
    );
  }

  String get langFP{
    return Intl.message(
      'Tagalog',
      name: 'langFP',
    );
  }

  String get langEN{
    return Intl.message(
      'English',
      name: 'langEN',
    );
  }

  String get langID{
    return Intl.message(
      'Indonesian',
      name: 'langID',
    );
  }

  String get langMS{
    return Intl.message(
      'Malay',
      name: 'langMS',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'zh', 'tl', 'id', 'ms'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);
  
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
