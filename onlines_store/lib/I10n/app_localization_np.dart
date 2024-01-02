// app_localizations_np.dart
import 'package:flutter/material.dart';

class AppLocalizationsNp {
  static const LocalizationsDelegate<AppLocalizationsNp> delegate =
      _AppLocalizationsDelegateNp();

  static AppLocalizationsNp of(BuildContext context) {
    return Localizations.of<AppLocalizationsNp>(
      context,
      AppLocalizationsNp,
    )!;
  }

  String get title => 'अनलाइन स्टोर';
  String get addToCart => 'कार्टमा राख्नुहोस्';
  String get removeFromCart => 'कार्टबाट हटाउनुहोस्';
  // Add more translations as needed
}

class _AppLocalizationsDelegateNp
    extends LocalizationsDelegate<AppLocalizationsNp> {
  const _AppLocalizationsDelegateNp();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'np';

  @override
  Future<AppLocalizationsNp> load(Locale locale) async {
    return AppLocalizationsNp();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegateNp old) => false;
}
