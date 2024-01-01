import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class l10n {
  static final all = [
    const Locale('en'),
    const Locale('np'),
  ];
}

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) async {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);
    Intl.defaultLocale = localeName;

    return AppLocalizations();
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get title => Intl.message('My App', name: 'title');
  String get helloWorld => Intl.message('Hello, World!', name: 'helloWorld');

  static initializeMessages(String localeName) {}
  // Add more getters for your messages
}
