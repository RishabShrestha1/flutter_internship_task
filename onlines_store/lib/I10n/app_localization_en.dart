// app_localizations_en.dart
import 'package:flutter/material.dart';

class AppLocalizationsEn {
  static const LocalizationsDelegate<AppLocalizationsEn> delegate =
      _AppLocalizationsDelegateEn();

  static AppLocalizationsEn of(BuildContext context) {
    return Localizations.of<AppLocalizationsEn>(
      context,
      AppLocalizationsEn,
    )!;
  }

  String get title => 'Online Store';
  String get addToCart => 'Add to Cart';
  String get removeFromCart => 'Remove from Cart';
  // Add more translations as needed
}

class _AppLocalizationsDelegateEn
    extends LocalizationsDelegate<AppLocalizationsEn> {
  const _AppLocalizationsDelegateEn();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<AppLocalizationsEn> load(Locale locale) async {
    return AppLocalizationsEn();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegateEn old) => false;
}
